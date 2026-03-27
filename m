Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E763810F2869
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 19:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4373583C14;
	Fri, 27 Mar 2026 20:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MmLxfBfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C0C83C5E; Fri, 27 Mar 2026 20:38:18 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF0E8394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 20:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLe2hZHhjCDV0A/mZ/cidob3ME8zXSUrjJsfKubjtuDX3gxFNjRaOZBaOuId+3QEGX1H16RTPJtDjtk/je27sjHl1yRnwWz0YEUd3eznRgxtTWuUG8WsoMO8VUfsUyQMEmDRjm+ChgdlQstDFb/yixBAw0mnrtdeayiPEa+VAI7f8GRgsN08zfSwNQOhFgGcgMgJ2BYaQmZ6RfLSp7RFU2098jDOoeRGkgsqKHWROeoe8aN9Otqp742+jYl8ktpftOwBBVfh0ZKlwUZfJ7odH1fMZVlC/aE+6ghP9o1p/0i3no73VzxR0AbwXA45B872yzDFIvnfdkyL2QjCpU+ORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KZaqKgiD3HIPEQGwHK/aubVMcvXnSmSHL4OJFbcMFU=;
 b=xCww2VxHiMPtFyNkPwxSsJ7rNF3Zu9zSj7z8Kl3LaTx1pN03WP+/ukdo4b7w5/0BsPLzDkpM1l4YujB5SSJlagNAP5p9hoIMhsCv/nWXCWLtzwyBPS2VRrJBrwJ+BtmJOpAN2TKtOnAiC96r4d4+RGSZ7duGg+9b5ucdyRmAYEMgOIvE+56n44UDhUvbY7q3v0kQnOIoDKF5fSxK0PyTYryCgGAo3y7xmklW0ND+M6C08ZbtGo7h96cuyDSIh90i3Mh7BEZt8wavM626njlmK5qfzRhJLtp2iCHTjWTTfliqXs/zSKmbxc5kHKCy48mZlCEkVOB385aqw61o2fXo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KZaqKgiD3HIPEQGwHK/aubVMcvXnSmSHL4OJFbcMFU=;
 b=MmLxfBfXYBm9kXCXGPevNIiuT3WTbfF3uvL1LujuiPrnggrFr1zxCdosb/M/jXCy7fb5l7wAf/tDlFADR+cEYTRtRUWpXXCZ3tgGXX7vwxKkxqIMI+m0CfJnaLkFbdXQRFdJdUDXz1plUZVE7WtP0F/Vsf4E+9XyPjS7+SJdjAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB9619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:643::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 19:38:14 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 19:38:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  u-boot@lists.denx.de,  Quentin Schulz
 <quentin.schulz@cherry.de>,  Francesco Dolcini <francesco@dolcini.it>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH v2 0/4] add [ as alias for test, fix 0/1 argument handling
In-Reply-To: <wkhnll7k5qq5jzjdhspaisvsoygscuhuqaqdz6sahrxwuhihk5@uedggycyvvwl>
 (Franz Schnyder's message of "Fri, 27 Mar 2026 16:48:52 +0100")
References: <20260312100106.702368-1-ravi@prevas.dk>
 <177447995901.3508238.4236856739882459467.b4-ty@konsulko.com>
 <wkhnll7k5qq5jzjdhspaisvsoygscuhuqaqdz6sahrxwuhihk5@uedggycyvvwl>
Date: Fri, 27 Mar 2026 20:38:12 +0100
Message-ID: <87wlyxjc63.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A08.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::20f) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc76a11-d0e3-4f93-069e-08de8c3862fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uRujP4f1pedxc3wI03aEqNExjrSTXLi1lDdhHmMRNm0VtZJKPNioVM0A4VwfBk7BW7vmfy22Nk/MrVUqhvpQY+KYQXPTuYg7Ralrvx5CSYaqIq49QFjUps0O4IhI24jqtIzi73G1XF1yvUQhO1vr/UsbdrJQfWT1JAXQ7OEh56x4zPmgOmnGHMROKzhs5S4hg/j6m3GIgV1ZHwctcCsvzFbsaeRt1xFVKlstUt2a6U9KzI+aQa4WFAHQ44NFCva/Wk0JrjboZQecbSR0cNs+bKYKhJiB+0QM1pFH6tDXzza24DjIATLSlZ2XhZ24Me6D5MGLCQKzhVOb8ByQRp3sdxw3gArscj9v+eUQg0J7xnjF8GBVhdxpaUcv1Hjd+JYE0kSLdrP2vEiDm80fpKHIxdCEz+VaxK4kNuu0l3hfV6jUi7AruyZ3HqZaX8CV22MtPMFbDcxlWvAZVPXEAVfzOfwmSC4B62BYQvwxYJ4lZNFPjASZKr/FyLEbyKfdPF8lp+QHF2HEd54fnEfYaGTXbb2aLRHJiHmQxFxPk2VIL+ktEN02oRmVSWm2xsnffl89f7qxLGY7bdy1mr/4WZC5MZCOPdhiiX22iR62wEVBDOiBPH0ipwHssrxHL8BXIODlWQbgSddwlcKgzFfbjtgNyC/n8HToaCvo5O/NMr+bKx0s78ruVSfUTvoRj1kClqcexLGidPTfp1vatB4NinIf7JYAuOQnx2wWTqqJc82L0qq7I6hHL8xvnYwEo/RhWaTAhpKmDVmGlQQG2HjG+LcOSHLqvXkhGVanoFTOp2kY8j8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dK9ELKtvjuaaGkLoAAq40RmRHdCQHIxZwrvpDVKfrraVws8B3UAFkMtQHJ66?=
 =?us-ascii?Q?qM5k/wPmUaQSECk3NUi6sPHXGnig4SUhcQ1wv9BXnUOq1f3e2dmh4yaa268b?=
 =?us-ascii?Q?Rxu5nc0zz70CfvCUrNlUqJ44IxCy5YBlqhVwFNx7uq3UPpoERFZ6hXosEYEb?=
 =?us-ascii?Q?GYnmeLwIzM8Tpr/ZdpG/QzI1Ni+ZcesWJuDOSeVcCd4Bug/rgFVqmxaZH+D2?=
 =?us-ascii?Q?MDARhoPttM/lkiQmCzU3liOHrf50mMqrQ3zf5iZ8BvaXGno6OUvztp6B1Gsf?=
 =?us-ascii?Q?+yL/6Ua4vPCcLXyoAWpSU60nwyEUpvwrRXbNEkOPNylPD6GukPmeI4EVjuL3?=
 =?us-ascii?Q?KkMgTI9JYc3CnRemLpOzEp2YI221gWr7ILI/FO+64tcH59KTedh0oOoG9JJ0?=
 =?us-ascii?Q?hY9vbuppDa5v9vrsm/fkV6MCMes5vU2yytY25VawJijfEX81vIYzkqGSC5qK?=
 =?us-ascii?Q?hwb10bXHd53ZwXTEgd7Kr3nU3G//vW9YvelwxMGqFKdqD8iGaIAZhDVsXCga?=
 =?us-ascii?Q?0TvXsgivuW2hMZL5y1sY+z23nYmlMr1FYAfzB9yOGiJXN2JF+nLThnXHWKJ1?=
 =?us-ascii?Q?Khrbu4FgVmWU5ZszqvHDawuB9ICxMPdT3/W+XssL9N3zgY0mq1SYxPQ6yiq3?=
 =?us-ascii?Q?FdrSb7sOHF+zCdE2W2NRUhUWqtNK8rUqpC5yKsx7WjO/uvjQ4mZydiKkglJD?=
 =?us-ascii?Q?GcueXny3AeFVqo9Iqh19ZvL9lkbYbr+DZKPHGMw7UPSX1ovguCYnAHXLzIyw?=
 =?us-ascii?Q?l7CN1to//92ooes2UWRaVi7BtRNKIJqFJwNOUab4LQiFzl/6FeKD3u6PBZbs?=
 =?us-ascii?Q?Dw5w61laRBMQTQC67e2Bg2E3+sh6bmrv0Qvq6lDonCunC2QfC6luO5L62bJ/?=
 =?us-ascii?Q?fcbuwZQ+45TOv+niPY+IFdqcGbg6IoFdTLFFHUdG7Oqi3f0vtLasfJz/BCV4?=
 =?us-ascii?Q?1xdrtcVxmsYcuK8wxMJDKTxmU0EV5YOln7qvOMkwJ72TJZLmXXKm888b4sno?=
 =?us-ascii?Q?ibkqVP2ckzAemE/93KGnmaI/QOz439OiA9L0sX9VnkVj5D9bUWCPEIJu7h4e?=
 =?us-ascii?Q?9oR1owZudRczDhJ9tLpc9O11wYDsqa2q+ptfHjyPexiBwbJd7G+/7ytllGpa?=
 =?us-ascii?Q?ILRy6P2BktYhr0Pp2EezvtBFUnEo5wVvoXguZZn/o2YeM+lJBYYh1saudtjL?=
 =?us-ascii?Q?lcmkBmtCNnRoMdTIT4IF+wPtE5vsHoDkHJHlJ2HzWi47cgV5Veah1pu9buWD?=
 =?us-ascii?Q?FIfknG7omYoxA8DC2r711ERuNYXvJsRgwnJ4C8Ih/XiaIDPAxq6ojA3VXS0L?=
 =?us-ascii?Q?2A+/QP0r1q2db9aax9hfLtjLJ/qDt6jtWcjIfGemkro7higSglXmG+Ug1c33?=
 =?us-ascii?Q?4wp0DEkkFDIjZOYDsy4jWhZmFSRrslHoz3G9JUsqS2e2F8VV+RaU6plon2G0?=
 =?us-ascii?Q?gXT3eSYNLTHdZsUG0GNc/S574gDL65vg+FBbUMv3UzVqUi5RdUt4l7hXXe4T?=
 =?us-ascii?Q?DPsQ6YTNcARhTOvbgwVicn5CeRA76QDfV1YJqAdreU+8B/2boQqpmjFGpDrM?=
 =?us-ascii?Q?wI7f9KH7bmZ5qeo8vthp+C/gAJ9ZlpARCOg27udiy8G/lAym42GaJKJov83K?=
 =?us-ascii?Q?IfWZLiQhXhYCulzbQz3dTrOPuUlUSdF+5FpPIFPFi7gMd9SQQ8z5ubKGjj+h?=
 =?us-ascii?Q?IG4XygyPzVjqjNmabuiJPpYCuRvhgjRVN3079rKdTzIs2RleK5ZMkLBFMtjO?=
 =?us-ascii?Q?EVOKJSFgvYrLFtg39e5cywGS6nt4Roc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc76a11-d0e3-4f93-069e-08de8c3862fd
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 19:38:14.1433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbbQFRznMs3T481TPdG9fMAeyMgXxgNRfB55j9C9kwfC2hi8m0r6EPwEVF0YjGoiCUQF28JrJRn5iEchwZGA3mpH3L+QD8TnaEg3GcS3UKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9619
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

On Fri, Mar 27 2026, Franz Schnyder <fra.schnyder@gmail.com> wrote:

> On Wed, Mar 25, 2026 at 05:05:59PM -0600, Tom Rini wrote:
>> On Thu, 12 Mar 2026 11:01:02 +0100, Rasmus Villemoes wrote:
>> 
>> > Make 'test' behave a little more like its cousins in other shells, by
>> > allowing the [ ... ] spelling, and while here, fix up the handling of
>> > a single, non-empty argument to comply with POSIX.
>> > 
>> > v2: update documentation, add a few more test cases.
>> > 
>> > CI is happy: https://github.com/u-boot/u-boot/pull/905
>> > 
>> > [...]
>> 
>> Applied to u-boot/next, thanks!
>> 
>> [1/4] cmd: test: allow using [ as alias for test
>>       commit: fc8bf9a984c118d551b3f93c66f1ae2733b9b588
>> [2/4] doc: test: document [ ] spelling of test
>>       commit: d44f61582947564991cce7501f2e5db0b29ebad6
>> [3/4] test: add tests for left-bracket alias for 'test' command
>>       commit: 6f9cc3310a764aaae4478b5a8a0c0cae3b2be4a1
>> [4/4] cmd: test: fix handling of single-argument form of test
>>       commit: 8b0619579b2282050e7fb0d92fbc645b79d18bae
>> -- 
>> Tom
>> 
>> 
> Hello,
>
> While preparing a patch series based on u-boot/next, I realised that 
> the bootflow on our module broke.
> I discovered that the issue was introduced with 
> commit 8b0619579b2 ("cmd: test: fix handling of single-argument form of test")
>
> This change breaks our boot script as it relies on the behaviour of test
> with unquoted empty expansions. For example:
>
> ```
> test -n ${m4boot} || env set m4boot ';'
> ```
> Is now `test -n`, as there are no quotation marks. It now returns 
> true, so the fallback assignment is skipped and it breaks our boot flow.
>
> Any ideas? I think that we will not be the only ones affected by 
> this once it's merged into master.

Urrgh, sorry about that. That snippet is arguably fragile and buggy, but
yes, similar code can exist elsewhere.

I don't really like it, but I suppose one could special-case the
single-argument case and interpret

  test -n

as

  test -n ""

with all other single-argument strings behaving as they do now. This
would need a separate test case and explicit documentation.  It's
probably quite rare that one would test a string for emptiness where a
possible non-empty value is exactly "-n", and since the single-argument
case hasn't really been supported in U-Boot until now, I don't think
such code really exists. Moreover, I don't think one should ever rely on
that single-argument behaviour anyway;

  test "$str"

should always be spelled

  test -n "$str"

Single-argument 'test -z' does not need special treatment, because
both 'test -z' and 'test -z ""' are true, but we could add the former as
a test case as well if we do implement the above.

Rasmus
