Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE493C47BC8
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 08:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E508883D9F;
	Tue,  6 Jan 2026 09:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DLUMo7EE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A094F83F20; Tue,  6 Jan 2026 09:40:35 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718C283A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 09:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbawXzt22fsHGx6olPZwyEYb/wd1gVKt4vOQSHM4smddeIR2eNR6c/5UCTYbf6tlo3aSGNeZdL0h6smdCARwR9Jm53TsyYrfYzGpgMr2uB/a0sLC/elsCzzaEkLoGewS29fK3FMWUbfZuBUyRTqAjwxg9pfdAYzUFMCCQos4lRnmJU7x1MsDZZbSA6KRx1w33U5DQbiMmNCIRHtN5gYNDQPLCCv5X3pnlbvcf55nFLMAeikbpxbbnoxji6kqtWCIVhOH12sExt2TUnB8i0XnR13XUYcJfeC3oJM0Yr805pAQrfp6qB8aHYJWMzCjUeGYAq3cPbPDxy6nq+IFCYmrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGehqoAL+4nd3Sd8DsAacSluLKklx7Ruv3+EUk1MSmQ=;
 b=kv7nGG4WrupuetzNZ1pajLv1Y5XufKQEJM3JQHidNDdsYOC6pyxKh9RJlJhxe4h0HXvN7K7l7dukm12p8LwNqCDiwItONXc7ILe/btl3FoJKgkSwyjhRQUXjNXDLewM++JCuVE3jmKaIxGarLItB8gSYIgUDazvJFRtWeuIii+VcOJDJ0obNLZth96g2CQUGo+B4sylA+Z+46dVENsyN5bYrGcv9g9jWy19OvBU59Moc3HXxpSbwGqw2wM+XdLiuDj0Ouh1yKrCn0U0N+60s9K51E/rL59TI21tbP5+YVHeN5S0DZR1rdyClv1UihkPJZe5muYRXU7w0P2C99Eeyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGehqoAL+4nd3Sd8DsAacSluLKklx7Ruv3+EUk1MSmQ=;
 b=DLUMo7EEdEfu7GPfWmwic2N5Y9udragh808bzNTaB3wIijzKQXfOO2teIsetZQUrC0lAYHsbKxbconS6NETKd8KCaeitrf+f9fiiSyhob2/VL4Fm31yUQN6HlC61h4LVx21Wr9X6fnqqeaLTkStLj8TT889IEzng5gE0+6JLV/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by FRWPR10MB9506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1b2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 08:40:31 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 08:40:31 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Patryk <pbiel7@gmail.com>
Cc: Simon Glass <sjg@chromium.org>,  u-boot@lists.denx.de
Subject: Re: Standard Boot integration - script validation before execution
In-Reply-To: <CA+DkFDZxC=i-wQqY6OV2rLO5CPFeXLWCKUYRNcDJz_AMt8eZVw@mail.gmail.com>
 (Patryk's message of "Mon, 5 Jan 2026 10:46:41 +0100")
References: <CA+DkFDbQr40f2V8eKD5cSECVTM6aZyeZNxbZMqT4SeQJjMu3fQ@mail.gmail.com>
 <20251216-left-mournful-0bdb19f7c060@thorsis.com>
 <CA+DkFDZAgjL3amMoLqSTQbbKngeBk0EMBTciBDDKrxV-UsP=fg@mail.gmail.com>
 <CAFLszThCnj+35+C1s3nFR0Rcofz7jTyymKyP9ofMTZMt2t4uWA@mail.gmail.com>
 <CA+DkFDZxC=i-wQqY6OV2rLO5CPFeXLWCKUYRNcDJz_AMt8eZVw@mail.gmail.com>
Date: Tue, 06 Jan 2026 09:40:28 +0100
Message-ID: <87ldibrv5v.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|FRWPR10MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd92484-0484-4dc5-693b-08de4cff4036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PTnoruLXITn6DCrAZMQmzL8i0qnEzUa2hlX6OrN9PwVmOcL7sFeLyNQgS2Qz?=
 =?us-ascii?Q?puzi8PVUxt2MLc/RHXWhdp/l5PGIqDxYOibzpiA82iThddx3koQEj6F4XeaZ?=
 =?us-ascii?Q?uNjiIF0auqixFQkXnnm7a/X+iC7PwRpIDXyvTVAQ/kw7ZPfTh4YA0OtzeBHp?=
 =?us-ascii?Q?qI+1pwFM1txIiv33VG6Y45NpAPlAPmNTtngrWRlmzAa5jugHXqQLNIv2OcMW?=
 =?us-ascii?Q?/AHy+3kFFTzZRZCWNQji+ZJm5GNaHvozmjzWxvs3lBu7DFnnKdwA1PkbQ33U?=
 =?us-ascii?Q?LE9/KZm2lzTWNfzV3qV6AcycxR1a8A8TSltuTSdM6zvpvwbc3EX47v7B4cRC?=
 =?us-ascii?Q?GDnhPVCNVO5EInz4gteRF7EnkVPHaE2OQKdScOYBXdTwniobkpOtveM9s+YA?=
 =?us-ascii?Q?g1gEiAHJAhcKtuuyTlzAkc9/U+MkllN6w/bq8THGf9E4ojMI/83iq4r75HE6?=
 =?us-ascii?Q?ojToclTJ6A6hwZ97ZgpkhWCtaDGLjsSS1Nw5K++lOHHFzSZpa+8IE5uvD/nw?=
 =?us-ascii?Q?CbzCWUzrVO2AtvnAzn4L61GRoz/Wr2MwiaSYP7s5xREWDdg7GnXGQJtQq0Sw?=
 =?us-ascii?Q?C8JY59ua4ViYGj7mxFYlFpPKiJcrgrkNItGWSmB5sAv+sGgGRje+8gl+vfKT?=
 =?us-ascii?Q?2wzm466JeMbPK+74Qs9BXydaTZwuHjQEGGZqKzr96GkRpZqd7vwXmypIIo7C?=
 =?us-ascii?Q?2byPS8QjdWmlXmyKi49qV6Rr5C5l8iGZVuNbc+rA0vZtdyT10RrdJef8Q7WL?=
 =?us-ascii?Q?JFRPo9xJExAOtNKxAy7zxIUihx0qO4+B1lJUCbwVzEUuy82HZ/ZainBNaG5c?=
 =?us-ascii?Q?GVIaxN4aX5FNIZFrabV5noVtMHq1cVTuBWmFfqwddISQIVJUmMxsClzSfDup?=
 =?us-ascii?Q?ZGVNQh0q/UlxTWkrZYVi7eC3CPygiOAdxOZcg7v2lZL+SgV2IVVN704n0rVL?=
 =?us-ascii?Q?egopiPSmmMH9tSU5G3+SExM5ExC5VBk09GF3Ss8eYX2D1Vvhw0HOvh/624s5?=
 =?us-ascii?Q?Rjkm2nZJWeCUHdNKr1Wf5NiwRk48vsCXtQb9yMyEJ42hHHaYnHR5BZq58qrR?=
 =?us-ascii?Q?PRb8/unym/I+4ADwTEKn0KQ4DWo/8t9WenT2zf+67QOfHmJvuvCGbZCP+1/Z?=
 =?us-ascii?Q?m8e/9YkI4uvU8IOfL+uNFk6pLLY6SkjTL8aDt7HgI59gZPSjRQO2M1Os7JU8?=
 =?us-ascii?Q?+6+RxLh+lUogoiIsOzafvOhV8OWJhyJ4ZLucFhir/CU5T1RhSPk62Wr4s5Fq?=
 =?us-ascii?Q?kCEnLYO4QyL3jB7uQAwuKiNgbfJTnZ1My+DpxaJAlFsidX4MgBVTLZIQyd0U?=
 =?us-ascii?Q?oyGhmbIgq4TxUb6CgV8Wpc44fL6Us6I+74VmwUzpzs9H83r4yThFnw/wn+1/?=
 =?us-ascii?Q?g38NJFKDKo8trWI1IZnEJS8aHiWy7T+/Muga9K6y32WYUbcKTRzZZQBZS5Hj?=
 =?us-ascii?Q?mk4xhgKgW66n/4+UU873mSZ76/ZzYmgamb0auBt3GIOvl8Qfs87Q2LtiqMGF?=
 =?us-ascii?Q?sOKrtDIQjuxPlf+EDoLZAvfYb214ZqPzDZ18?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cwvIlx4Xtt6/ngjwidZKHJsFMSpUOK/Gu8h1+k7WRU6MuBFe4MfZ4Yds8vLJ?=
 =?us-ascii?Q?Z2zl+Usws/S3nwBhJIcCbZktjxXRuyngghmZYgUJT3N19ISbfrCvu5z5vBkS?=
 =?us-ascii?Q?5Bqghkt0M4znleHGCTKzbao1D+StjJXzxo7gTD66PchUeDZdM5TqxyBBG5r+?=
 =?us-ascii?Q?iZiinPN3OcEeZ5ppb85IG2o/4+HApAWvkCqyebblzZEYSLV8yPcDptw2SQaV?=
 =?us-ascii?Q?VqBRFgBDtn+AXhH1Atn7rkCUeazB+JmW2kajPkd2dPvhEoBr8aCEfJO3Pa3W?=
 =?us-ascii?Q?sz61oMcoLICE5TK+qUkmvSXweXioo5Mv2PbHsY8ypoMnEhJNpgYjnaqpDplV?=
 =?us-ascii?Q?CxR3ruh/lg/Ba6SYBGQ6jorJEE3iqECVkV9k9KKZX69V679MEW2dEvp0XlSu?=
 =?us-ascii?Q?wxzTvX41VC0Omr0ijhV/admV8XGPIncpOSuKM56iMp4LN6aeM5no6pesrjxf?=
 =?us-ascii?Q?rAx8Nq8CghL0UwpA/PWpwPvOaix0105amIyYqfyXPgcglNo0hINTTwMTMdzg?=
 =?us-ascii?Q?Xy/tb577sbTZVxcyvumLLP3UO13xuiaRdqCOmdE38rL8e147CHng4zmIXt30?=
 =?us-ascii?Q?cCv/VeL+Dbe/D8xtScFiapeilswVN8fljJynx1HFpj0UpLwTaIH59I5RbO7n?=
 =?us-ascii?Q?7w1G3XFG0mmjK8FTjJK0JTdetuY6VZ3VfWCr2MrddzHx/kkr4SKnx+Z+2GUI?=
 =?us-ascii?Q?oRzCD2B0i3MVPxpA3y1lTutD7lXpZ3MCeJEvbUSEp4td9UDF6BxoXXnbSPfK?=
 =?us-ascii?Q?OUkI7vBmlFFVKUi2SlPz4tQoZXA/Che7ZuXODpAwiYz2t0MRnNWHvGH//aGE?=
 =?us-ascii?Q?yaH3P0HcScn2TjDAbolmLrfZUiu+N1636DqXz588l4dah9pTLI6i0jRKyd3W?=
 =?us-ascii?Q?RcZOzZRhoy9XXe+Ms10wVtXR4a0Xgvna1ARfyouS3P7cbSMuvP5fGjvqJIPr?=
 =?us-ascii?Q?tLsvuALg5fyulRZcufdb7/3sWUoBFsU5nqkrH2zCH+txR3Z+Ogo1iIcgRtMk?=
 =?us-ascii?Q?xyxoQqu4U44pfKoe351zIsDftC3bnfBK7n7Cj7unl9CidP5QnQ/0XX/Z1Qtw?=
 =?us-ascii?Q?IrJd5OykE92uE+ImJnmDZxHDjKY5r+UEArtXf+zkKNEeC/Pf+tck7kBx9M+z?=
 =?us-ascii?Q?L/pS9t0xqlc0yUy6B8pkrmRQqfPXlrdkJy2em/5ECy9nTlMvdRCUfaYJbu9L?=
 =?us-ascii?Q?DJvJaIZjbVw/XATSGAYzA5O1zsZP7Hw3g7VrGhy2msblXLAYINS6RjeoEmzy?=
 =?us-ascii?Q?8w7RWgDkccbSHYQ3FwRexuyrc6MoCzMnNSj2dY5DZJfBwYx7o7gR7QXVpIP8?=
 =?us-ascii?Q?YWwqQk/exAQ3uJldyCPe4Zoe3jg1R8uVRa5Aq9guQlItC64yoTtNQRF2Dq52?=
 =?us-ascii?Q?uO6J/A3h4XZaiaSMDTqEJT8c7AeDrDVzFLV2lLqJhiEkCHv7mTkErwTR0V06?=
 =?us-ascii?Q?UKscHhKfcGQmBgL1O+yp85nprdPQeDyUbo6G7LHKJaQfNzfSeJtJpcuy41Sp?=
 =?us-ascii?Q?xAF86qCkX7x+gjgTGJg8hHVi7rEXbjAb4zM8fXqULAfqr3cPOqXrEBbQX/Kf?=
 =?us-ascii?Q?xDwwMML6E2ClgdpxEeJaHCRlvEhpmYVCp+Osk3bgDhmipjKtw3qBYxUHdM9F?=
 =?us-ascii?Q?gshsDu3GVV8iM+Ngg/h7mVpg2eQkW0Fz2TJfIvo/P2PY6dJNA/MKsTpuPIWZ?=
 =?us-ascii?Q?gJTlsyBRRiasaltTyHOKHTAR6KnYsGzDGlRJBTKTg1BAdKMDNFbv41cL0iEe?=
 =?us-ascii?Q?bsqgSEOb8uCA0FofXc0Oj2CP+41QYcM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd92484-0484-4dc5-693b-08de4cff4036
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 08:40:31.2626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jm361ixKxL+DSIcjSXospFQJxYHwXW2wgXy3q16NT97hwop4fYxMtjE+TcQMKDgkOM7XTToT++5lOi+SpkCfubBmMsb1PigG7dk+70ov0E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9506
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

On Mon, Jan 05 2026, Patryk <pbiel7@gmail.com> wrote:

> Regarding my question: the more I think about it, the more I am
> inclined to implement my own boot method, although I am still not
> entirely convinced this is the right approach. If I were to rely on a
> boot script, I would most likely need to introduce bootscript-a and
> bootscript-b, along with a mechanism to select the appropriate one.

FWIW, what we do is to embed the bootscript in the u-boot binary
(actually, in the control dtb via the -u-boot.dtsi mechanism). That way,
the script is automatically verified as part of whatever mechanism
verifies U-Boot, and it gets updated in tandem with U-Boot, so no need
for having it lying around somewhere separately and having to pick the
right one and verify it. Running that script is then exactly as
trustworthy as running the U-Boot C code.

Rasmus
