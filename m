Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E315CC48297
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 14:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3E9877D3;
	Mon,  5 Feb 2024 15:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="Z8edZfmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C82877D3; Mon,  5 Feb 2024 15:28:25 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BEB9879AF
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 15:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmsH7TANFT9giHJDqsRy3LPHr+nUDZbC9KJzr6tlBN7pl1GIf0m8fG6zmv+JMlrbk3y5gnSahVcsfOWghrsiupXVy2Q7B5Ay88Q/UM+iC8dwefN+GM9kvqwWQAfE2FzAU5nd1jUSrJMZ5XMl6Ok1yvYCf8vDkGb656yHwrf2YH8rgIG5ifKCB/M65QCQ6vcWIdfgk+bU5E9uVIP7ROVEGV3Rkl5S8cFtd4Mmb0irOM+22ZrhM0AQGt0zuftV48irC1dapxPrBUFMdgWNN8T2rE5ZnH7eKF376pCmMHibT2MiibsPIdoTB+z3H7MISiYY4cacy4yEeMWtsmhBg2xIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2JPIOko4hJmSUP+nD5h4z4wvBAfjMHZMmrVR2Z95kc=;
 b=YrXgAlCvmiN9jS5AIr9tUa2FkeHDSQlFTpt2a/HhnZTF0dI47QFglw3j1QGBIYOB49/3xtYS//PhV2bZ1JJKxSx+TG5y79FAyi8K1r5Vdi1EvmBJHWbxPx5OmeZ7JsmVspxD0WOznaktMBih9YtPC1uD9cnRht3Vn4coMVcIaXs8u50CQY/lggkBWp9i8KiYseTrCVK8BBmJ9EIvP7p0RwWZDh3oMrIn0+Emph3CQV99ovs4vRmIWydJxlFFEUEJx2MGI2jeBNHF7I20qdvyIa/N+O0B5HtKuNdAsJuLOrrlB2aDqiW8Ij5ZIlkPIkgtdseJuVW6m3nyc81sfnn+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2JPIOko4hJmSUP+nD5h4z4wvBAfjMHZMmrVR2Z95kc=;
 b=Z8edZfmD+0ebj3crZPZ27bMFyvhcqUmr2sN+r1/kGZX6kIq/3lCb3rVkLshdkieYzEJaWlQ42jEkvq1llB/ZD09E9pyTqc2swv3PL6GNgGYn2P6xiwfKZyrNcHYWAb8XwsEMZQ2gYiWQol60uUH+zdFKnwy/sIWarTf4kLBUexw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB9741.eurprd08.prod.outlook.com (2603:10a6:20b:617::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 14:28:21 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 14:28:21 +0000
Message-ID: <c86b3a57-3068-46d1-8630-110c46622134@weidmueller.com>
Date: Mon, 5 Feb 2024 15:28:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: setexpr: fix no matching string in gsub return empty
 value
To: u-boot@lists.denx.de, Massimiliano Minella <massimiliano.minella@se.com>
References: <20240202143657.3883166-1-massimiliano.minella@gmail.com>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <20240202143657.3883166-1-massimiliano.minella@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c09612a-faf8-4df7-e04a-08dc2656b431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JENWNVF7EHhrI8lOV2a8IcPJjFMQE6oxy54nWOGLk3yV66xWLafdOyKuonTQKHv6D8OMcbFDNiPfo0LJE4BDWS6fuzQWKUi4q0Sp1zOZTgoP6bz/ZMavz4IOQkoDyjnZPehdZ/aulnI3QYSnux//VBaaKIAZ0vSffVDRLQ4Wl4Iu0Ty/7USPUrjqA4r4s0fTSr2LOzbEDFVtnzDg/HGmFm1hjUu1aAWj8F0OUheZWZjxYdDSMiVewsOCAshHPC9gD1O9LDeRVl1tee629Z3O/0cvCaOklnzrG2Y9dNuB1ZJNpczLGsMr6oTeXVi/J3sKQbpRYdfjBTwSkVxZJbH2m5Q47iZufQ8Xnb9NOiDJT6k7L8lPT7wsP3Tzjzqurp6bDKeqho+0pcp7gQwNYnCClfSRhED/tWrF24U513eTYGtAnxDbEuadXiZbV2y1cU4UT7UXIiHmWoQNcVDXCiQH0tY70zYtCUA9R7Fl8xx7iQKZcMB8HwSJ3Km9Dnnxb5fDK9NtPxxSkH76L4Lrtvu1pSsxP1NEPqfl/y93k8jzF/zJYQjynC1OC9mVaon2bMeayAWt2jdDL20hzAZAj1R/SNx5ulEAxppAMo6bMqXEWBwAIlkaJArzQD8SrruRdLxtmDr8EyerWdd28j0UJuE5VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(6506007)(2616005)(478600001)(83380400001)(8676002)(8936002)(38100700002)(6916009)(66476007)(66556008)(316002)(66946007)(5660300002)(2906002)(6486002)(31696002)(53546011)(6512007)(86362001)(36756003)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFlOHZLblA4bEVRWVY4bGhlNmdtNjhoeUNLeFZka244c3VSSzFlejlXNHpV?=
 =?utf-8?B?UlZNQk50ZmhVQ1VzR1habXJjdGVmMktBaTc0YmFWUFdHZFd3VFFzbnRBUlRv?=
 =?utf-8?B?MnRyMnJxOUNzZUJTRmtVL2p5V1d2SXNEWUFPK2VHelpKU0d2OWJwWkFwRnlB?=
 =?utf-8?B?YmpFNnYyNWtBL1VVZXBFMVhac1hpU1lZT1VlN3dzRm1PM2dQZzVEYlBDbEZB?=
 =?utf-8?B?cFZVcUdWd28veFlreFhLalAwWVN5T3BwUjVhY1BKTlcxWCtYMEJQTE0rZVpn?=
 =?utf-8?B?dWpPbXc3RDlKd0VVbkJsa0ZoNlg0VzVwd1RmUTJsRGp2MENWaWVuQmF2bVhv?=
 =?utf-8?B?Qk56TXpVcWRzSE4rTmlDYjcxWTBTZUZKdm9yTVY5QVh3dGRPMlZkUWpoTm9w?=
 =?utf-8?B?VFVtUlNaTVhSeHQ5RWVxUCs5VXFzeXV1Z08xVXBxcHRjUE1zZ0ZwYXE0ZjlW?=
 =?utf-8?B?KytkK0JxZ0c5R2lIODhUeStXT0NUTHNaQk9lK0YrcW9ia1YzNE11VzIzOFE0?=
 =?utf-8?B?Rjh5N2tWRndJOGpBZDNRNXV4cVl3NXhTNGpkT1dJcWNDd0ZuUnFqZVFaUk54?=
 =?utf-8?B?d25GemZGVytwam50cnU5K0VKUnBYWkY4UVdmK1RMa2Rjd0piSjBMT095U2p3?=
 =?utf-8?B?TERhNHVVd2xxVWxjMUZlL2JuRkIyRWlTWXk0SFZSVmUwd1ltUTRMM1R4UmRU?=
 =?utf-8?B?akh4ZUJGUnd2WTJJdVdsS0xoTytkbGpMQ2IxTlVyUXM4UTV4L2phUEdPVkVT?=
 =?utf-8?B?OGx5V1pOcXRlSzArNExWcVpqK3FuSmNuRk8rUmRyUDlqc3g0VDY4NTJRWGNC?=
 =?utf-8?B?b1FlblRsaXdJWVJNUldaSGdzOWdtWTFXcmg2V0l0d1ZIbVVXR1pTYThnRlho?=
 =?utf-8?B?UmMrNlZQNlZmR3FqQmhrSHdXNXRYZVRjR3ZIRTk5QlhGWURhN0xleGdOelB2?=
 =?utf-8?B?SjVzTSthOVBUMmhITXI5ZStwNm5RQm1yVXNpaVUyemo1RnlZVjhSUW0zTkEr?=
 =?utf-8?B?dE9GTVZGcnVIbDdzeWhSNTN4ZnUzRGhFVytwblp2eXdjRnNZL2ZiQjhUN2hG?=
 =?utf-8?B?WU1TUDNHaThUSXJ2SGxMRTRtc1k3TWRBZWtBNmRYajY4VGY0R3JJaENWdUpT?=
 =?utf-8?B?VEcrQ1o0NGV0Q1lYanNmVWd5Y1NpMWRtaklGY2ExWGZFNGY0QmZxaXlWR0dT?=
 =?utf-8?B?N1M2SHBtaXpZSGhWL0QvaThwSzJwaXdaeTFBYzBJaTBDd1VFV01hd3lTVzZi?=
 =?utf-8?B?eCtMRVpxZVk3U2I1Q05JL0N3Qzd5Nnk5cW1HT1ZUakVYczc1WXVDVmdTc0p3?=
 =?utf-8?B?cDNIMXlENzVpdndlc1owOEt6MWY0MUYrbDZuMUtWVzZ4NGtDRVJjQnRoMG1C?=
 =?utf-8?B?NEk4TTkwTldpL1ZTYkU1c2hpTW1oNWNIakNxVldKUGk0amJxZ0p2K1EwOEVm?=
 =?utf-8?B?NkZwaWs1VnRReFZTNitWWGlBRzVISGJ0Z0NiMzJ2SjFEWXI2R3Y1UldpQ0l1?=
 =?utf-8?B?WjY2QlNlMHRtT1NWSjVJTmNYdzd0SnUxaWNoQVYxd3czR3N5T01DSDJkOTds?=
 =?utf-8?B?TVBTQ21GTE1hNEVWRnlQaFhJSWh6eWJWTTV3Rm90N1FLSGZPOW92S2NrbDlv?=
 =?utf-8?B?ZlFob2lLdkQyRTNMaEUzRlZEeWdaN0hFTXlmT0piRUN2ejQ4a2RLcElyMDdp?=
 =?utf-8?B?MkVHeEh2WHhlbCthQjRSTlBCVWdGNW1sSFJVOTQ4SnU3K3NodEpKTUpzMFlD?=
 =?utf-8?B?UDVPV1BnWHhLRVk5TUhUcmNUOWI2dkFCenFDV2VOdi9TYW83Qy9jcEhPaHJZ?=
 =?utf-8?B?Q2pXMnk5V0xCd1JCTXQrUnRaWmd2dWw1ZFVvdlVScVZyOGZYZGxXbkpIMEQz?=
 =?utf-8?B?ZG50eE5YTmpzaEY3M3lZQmhBdFBuSkFCOHY0Skh1SXJSbkw5VkVWRERKVFd3?=
 =?utf-8?B?U3p1and6RkZvQXBYK2dUditwMDZxTGVRWXVKc3NGblB4bG1DVGZieDdGZVpr?=
 =?utf-8?B?aTQ3Tm1ydWhDN3NoUWIrUXZ1M09nNlFuK2MycmxsNHlPelVVWDI2bnRUY3VZ?=
 =?utf-8?B?OWN0MWc1TWx0d2JHbHZnL05vS01vbFMzNk9SVlJpYjRncVEyVXlmVWZhYUxW?=
 =?utf-8?B?T25tcTBXK0c1YTZoUkpnbWovUXEveXh3WjhzSU95TnFtOU5WR3RGdkIxSFZu?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c09612a-faf8-4df7-e04a-08dc2656b431
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 14:28:21.2793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kokUa4j6llvSwHIbd3XILx0eAp/WhQies+dQ+6NcHZ0cl7KHWAH/pSf12jQnXGu3byxHoQ9MklZaY3NpU3PTkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9741
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

Hi Massimiliano,

On 02.02.2024 15:36, Massimiliano Minella wrote:
> From: Massimiliano Minella <massimiliano.minella@se.com>
> 
> In gsub, when the destination string is empty, the string 't' is
> provided and the regular expression doesn't match, then the final result
> is an empty string.
> 
> Example:
> 
> => echo ${foo}
> 
> => setenv foo
> => setexpr foo gsub e a bar
> => echo ${foo}
> 
> =>
> 
> The variable ${foo} should contain "bar" and the lack of match shouldn't
> be considered an error.
> 
> This patch fixes the erroneous behavior by removing the return
> statement and breaking out of the loop in case of lack of match.
> 
> Also add a test for the no match case.
> 
> Signed-off-by: Massimiliano Minella <massimiliano.minella@se.com>
> ---
>   cmd/setexpr.c      |  6 ++----
>   test/cmd/setexpr.c | 10 ++++++++++
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/cmd/setexpr.c b/cmd/setexpr.c
> index 233471f6cb..6a7c0c914b 100644
> --- a/cmd/setexpr.c
> +++ b/cmd/setexpr.c
> @@ -216,14 +216,12 @@ int setexpr_regex_sub(char *data, uint data_size, char *nbuf, uint nbuf_size,
>   		if (res == 0) {
>   			if (loop == 0) {
>   				debug("%s: No match\n", data);
> -				return 1;
>   			} else {
> -				break;
> +				debug("## MATCH ## %s\n", data);
>   			}
> +			break;
>   		}
>   
> -		debug("## MATCH ## %s\n", data);
> -
>   		if (!s)
>   			return 1;
>   
> diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
> index 312593e1e3..ee329e94b8 100644
> --- a/test/cmd/setexpr.c
> +++ b/test/cmd/setexpr.c
> @@ -179,6 +179,16 @@ static int setexpr_test_regex(struct unit_test_state *uts)
>   	val = env_get("mary");
>   	ut_asserteq_str("this is a test", val);
>   
> +	/* No match */
> +	ut_assertok(run_command("setenv fred 'this is a test'", 0));
> +	ut_assertok(run_command("setenv mary ''", 0));
> +	ut_assertok(run_command("setexpr fred gsub us is \"${fred}\"", 0));
> +	ut_assertok(run_command("setexpr mary gsub us is \"${fred}\"", 0));
> +	val = env_get("fred");
> +	ut_asserteq_str("this is a test", val);
> +	val = env_get("mary");
> +	ut_asserteq_str("this is a test", val);
> +
>   	unmap_sysmem(buf);
>   
>   	return 0;

Tested-by: Lukas Funke <lukas.funke-oss@weidmueller.com>

lgtm.

Could you maybe also update the documentation in 
'doc/usage/cmd/setexpr.rst' in order to document this behaviour?

btw: I removed Roland from the address list, since his mail will bounce.

Best regards,
Lukas

