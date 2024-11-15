Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C71CD68BCF
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 19:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C928917E;
	Fri, 15 Nov 2024 20:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MZiZ+pyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C99A89185; Fri, 15 Nov 2024 20:21:41 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6270589165
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 20:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzEtQYNJTQVkDDAxV6YO+y+oYF5cKV7AajlNOistvE+93vid5FPiC922l3jo0GYTeNVBO91srbLPX2jPw+5TpGxYTqGZszrG339L5kmS5CcdbY+VyeXmCI8VEgneTIzRyTpyUu0TKuBBu8Oa7VzpX9OyxftWyXuvACO6SlbRfWCatFdYSSmd2NrXWZR81/Utj4f23XAAYbdUcw9B8V/hQ0E92t3efiQQpGjTwAa97dvw798BMy/6ALhiLXlHiXXXSC5UQhXJBEXx+3NzNQ/kpTqxgTeIkbWI4dmKQS1RDxzPW85G1nlJA//iDTHWrx6fRo9ZbbneRiaInj276NSc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKTUb+GHnzA/N0iZ+Pw6MbaDEnVCvDX38CDdMY01/c8=;
 b=H2RbihG1O5mnYb0UXnBptRu0itxoAxT5ktgHYq+qE3c2wtI5Gy8GMizPlzmUSxbhlGS5+U6/ygh4CaCCXA66hjQlvUpSNgMjLd7BBItRUXgdnSiXDV2Yr+VznaDFoN5sYBCmtfDkTMHNGxa3G+CH2lsNGwRbmjwHWm9nB/fJyd54acr71tbl0NBawNHYTz2igoN0le7rs2swEeYd3pAuvtTNGMcfptlufoPJKAVuPHMIcX06fGm1iEhikrrJp+uID8lGXjYSM5Tj4wqKTn9u+ip++WYy/wYDARFxHDROEKi14mh8M4RdaCXAnKAYupBTYk93ZTJWw0CsAbqnyaJugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKTUb+GHnzA/N0iZ+Pw6MbaDEnVCvDX38CDdMY01/c8=;
 b=MZiZ+pyYvcSWVm0LubKNhm83G1aLTJFMudb4h5BcRLwSKgjdtcsdF6IGeZ6yAK6LJg95WQTC0LVqR+uwY8Dg8TqRFK6OdVxMUoTOhtcHjXGjrq6SfFJu7B6smIeaDg3MpbM9D5uLAVRUzf0As7LSgYg0vgYhlKRe7d5TliS6fxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by GVXPR10MB8781.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 19:21:35 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 19:21:34 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com,  heinrich.schuchardt@canonical.com,
 hugo.cornelis@essensium.com,  sjg@chromium.org,  paulerwan.rio@gmail.com,
 al.kochet@gmail.com,  ada@thorsis.com,  philippe.reynes@softathome.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
In-Reply-To: <87o72g1sbd.fsf@bloch.sibelius.xs4all.nl> (Mark Kettenis's
 message of "Fri, 15 Nov 2024 15:32:06 +0100")
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
 <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
 <20241114173927.GJ3600562@bill-the-cat>
 <87plmx1h4r.fsf@bloch.sibelius.xs4all.nl> <87ttc9m0cm.fsf@prevas.dk>
 <87o72g1sbd.fsf@bloch.sibelius.xs4all.nl>
Date: Fri, 15 Nov 2024 20:21:41 +0100
Message-ID: <87bjygmhfe.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|GVXPR10MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b5a203-01a0-4c4e-cd4a-08dd05aab7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZfSMkkmUm8Wdv3Aj9O+uxSefvtEbsJg3GifNvh5qdBDf2AiVb/L9KCyUYP+e?=
 =?us-ascii?Q?5xmG1mZwgAkH8IJAv7SB4PbMHA2ZvlqriVww3EpsIxQuhuocpZpygW0sdtLJ?=
 =?us-ascii?Q?lLDr3X5563imlXKfDDaIKY21uK6dUideFfS6/woSgCQJSCrA83uvXd9xdBg3?=
 =?us-ascii?Q?cDuPqZ5hIUIuVInijgfo3rSpNIeOaEV5XQETmU1RWBt7HXfYEyjv1XNzGZl6?=
 =?us-ascii?Q?FAYXh8RL9o00/VXklYCaxz5S86UmumPfeo6KBpzFSg4J4muNfcaAuYn5TFyB?=
 =?us-ascii?Q?lPQZwG9TesCXoEhU/crAS4UwZjbUTxjGEXECJ22qwLhgwYA3em+ijggrJe94?=
 =?us-ascii?Q?+ZOpqYH9t4qgG8qGx1az8eJ2ur9bNowgBXJGyBu6Xn+TQPhu9SYpwDC6a9jM?=
 =?us-ascii?Q?EcHh6/Z+G0+hbT/SP57kItjg1VC7AJrqcfOh9GnVmbJt5XWpgbiPh9fU9zwl?=
 =?us-ascii?Q?3bEXYdJld0e0Z/VP78hygq8xZ+LvRAYMADbdBeBe7QmllM8xBoi8FlI+Z7N1?=
 =?us-ascii?Q?bivXZutBe3SaX+lcjK9SH2NnD+ZFZA/pavuyRgQ8TcIQNtP7BEUe2B9AAdH9?=
 =?us-ascii?Q?g0K7YZjBvVBFu0wR7E0756xT8sG+t8V9QrOa5sCNnzL2ZqPT6sAH8ngSI/XC?=
 =?us-ascii?Q?dZLZCl8MxN0nHU+EJwxVdmz6UO4MqeF9w8XAnYpwnn4BzUMgVTzv6OzgZkMI?=
 =?us-ascii?Q?+I+dR6TvVGt546PsuH/mjXS+TYbS8rF6sFNc/fXmaPZyszRDirh9CpPOmPSX?=
 =?us-ascii?Q?q+VQyc/6C4mTUOcW90kmL6N4Z3VjILzNsA3u8Uj5EIgn0OlJyew8hI12tE8b?=
 =?us-ascii?Q?UCF90YXRUJTPjtxknC8DtqRr5FOAotz+3MPJQqRvES6L6q01oCtPlDSojMSj?=
 =?us-ascii?Q?Y2zhv4sJ9Gczxb243fzF39pJjbS1Ce+osgh52eKed6A3BHc6kgfnZ4xR4AHu?=
 =?us-ascii?Q?vRR5d1bbccmk1lI/7rAEb2XrETtZX88R516nrCPb672D44O5SWRETlQm3zVz?=
 =?us-ascii?Q?g3dAktiU2YmjvBu23xa5dIZ+IHt1bOFtngbtwWWDiGxcYETIA5RuEucQd6Ti?=
 =?us-ascii?Q?06i42f+KTlmIGOV89uQtBHFtrij6P8sTi2DOdPXm3Z4A6sfGVM0q7BUEiwVu?=
 =?us-ascii?Q?N+fnLObun4KNqj2ovgaflXlrCJ4OwwkrN9aK+r4Ox8Y2nN4TqZwG+4+A1Oih?=
 =?us-ascii?Q?IYSkj3gnYip+pNHNb5TxhLI49DU0GNFXbCbkhWA8vvTCPy0VJxxsScZde7Q3?=
 =?us-ascii?Q?kX+Pc8gu0dVRefD+jBYDRirArna+4Dsjg2dbCdMNDlg5WaByOTLbQiv652d2?=
 =?us-ascii?Q?Zqs5ZytoAX9EPScoPbSd0Qw5IlCCim7j23ie+UQGQy6dPQ/Nvpmpi6NeBpSq?=
 =?us-ascii?Q?cI8yksk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Je9UihhnrT5H/Q/lfrZvkruZXnfwWetDkpKQF4JKfyJagPewVzv9lam3c6up?=
 =?us-ascii?Q?LXq+JUUq8zKVMgcVRof/a3MHucTo7XEKT1VP7vcPttl62GIJVX4nsDutWdq8?=
 =?us-ascii?Q?dAzTR3XijcQuvbYSfOm2HwegmcNp9jt46g5F+DDnci8kYsO5F5lllPj+hc6A?=
 =?us-ascii?Q?Hzfx1CVBOER/a67BTNaHbPrgHBDRyX9VBGOb8C+L5Q9lYyJGA35EgX2W38bw?=
 =?us-ascii?Q?m8nq89uLJH+Sbk+fFT3Q8noibgFDKuoLF3WoWNgt0ZpmBBBVo9Ymyec+FE8R?=
 =?us-ascii?Q?xVtGV2jbapeKJysgRV3ouJfq+oq26J3TwfAWU+bmCa2Dn94joBhrUz0OcSxn?=
 =?us-ascii?Q?bbtpNvwRzuQu66kZ9ZhCiTjOTW+6lhuwj5UWzqppWrBDZCi2f7TvijAib1Qn?=
 =?us-ascii?Q?AAolU718cIlRX6iRxXtqiTn/2+V/ftmkEEHNuQs3KxeoMP/vQ6Dm7boDDXQW?=
 =?us-ascii?Q?sYI4efoVF/90RZhBx2JKk6DQY4rRiONbi14BDT4OXyuIi6Qy+r4kXVvLT+rL?=
 =?us-ascii?Q?OF7sNpf10BM05D+ov0gfo4mSqQ5YIssPLWBBmgSFDih2Oo1pBqEQ57S+hYKr?=
 =?us-ascii?Q?3dFbmndl2fQ4SO3aO5pNB8LBRhdDE7r7TM0w6FLokAULfYpYYl7Q4pP9TZz5?=
 =?us-ascii?Q?fD5v2hlIpSmxZiRZGtF9Ham4WMSK2IG3gS8pO0gunmQrqpWMOtaQ9RxeZURw?=
 =?us-ascii?Q?q9FuFvtpq2cBw2BqcF4GmGGp9exgKwx27Vtf8D2ir5A2qkqkc/eSfbngXdyT?=
 =?us-ascii?Q?ar1VwxraHKURX2XPnJMEQqSdYwIdns1CSImiZTPSAYlZ33djdkiFDRlZV1hh?=
 =?us-ascii?Q?NytXMejsL1Vrsdp67JmbEuS64e41QW3w2AbSwGTX7sF9m+bl0zNcK0vhmXtA?=
 =?us-ascii?Q?H/XlUZ75oD8UaNc4wfbalVdxrBHy6cnbK4kG4g3rcn7PzfMoFuEeejAsoXFT?=
 =?us-ascii?Q?BWdBiybnzq5k3RvOKJsl1oIoCiPF8A59EhLWs4YmIEp4xPlKQIXsT0Xq9uLv?=
 =?us-ascii?Q?Gz97H3xlf+0yylGmkfbJ6S2H8/KTUvJvg+QpVkwRXf7ILmGnhvZetDBGvMbp?=
 =?us-ascii?Q?/Hl+qPeBm8vyc9YtGIfntQYCIeKJt43rfH3Vp8jLdy+1SvXqqcYLJ1Ucjwgw?=
 =?us-ascii?Q?W5lVFU6Hx8frQIdacxsaTJBSNXGs4Z66BEJYgNpONVIn7vrhhXEZMhryqtpD?=
 =?us-ascii?Q?vSwd2hBJhHYQSjIus8WPLmctNWVXbnXNUIJdUm6v7pQaxV4VqpWkUTtqf2NM?=
 =?us-ascii?Q?GJNiKbQqRjzi5X1YG6VDFq1JdtAyOusjFov7SqhlLO2/MVl1VhB21VebbsH7?=
 =?us-ascii?Q?FoGYH/dq6LLa5G52VUblTlOVLhsfHQjyaCOAiBTm5U7j5DPRamJg04SqT6/8?=
 =?us-ascii?Q?vv4uaZaE+O+dYfCAzPsBO7ydD2OGwdu7ZIhW/OeU5aA4YOGrmDHxItRL9N3j?=
 =?us-ascii?Q?LNsw50vFk6q412xge4ZVo8mvp3jHtnNKpgoDQ6aKqnU8+YL432pffUeajB6L?=
 =?us-ascii?Q?rKrFcXOHtCFF7dk0BPDsM1k5QIJMP0dIDYO+SHWSG0Pza3VSXJ69k9nADXYz?=
 =?us-ascii?Q?GgKgg8xKXiYG6qHdzxbupnlsclwVaZ3B2QQ+YSsLgWR8FTuJPlc0pz8kmaWa?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b5a203-01a0-4c4e-cd4a-08dd05aab7fa
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:21:34.7702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZLHYtIndySknVm+Ty/KVHUJzt2clqBtkuPx6he0PDLd6yuhldJ450jqsXpqvEQlZ1mHPjqEvGaUE6HdTD1j8k6+6SLLcv1AjpRX9vsqCjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8781
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, Nov 15 2024, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:

>> 
>> Or use getrandom(), which according to the man page has been exposed via
>> glibc since glibc 2.25. Or just read from /dev/urandom which should work
>> everywhere.
>
> $ man getrandom
> man: No entry for getrandom in the manual.

I assume this is intended to inform me that getrandom() doesn't exist on
*BSD? 

As I said, reading from /dev/urandom is probably better as that also
works on BSDs automatically. If somebody tries to do crypto stuff in an
environment where they've removed such a basic device node, they get to
keep both pieces (i.e. the code should just fail)

Rasmus
