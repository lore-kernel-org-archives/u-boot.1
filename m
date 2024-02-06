Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B93CC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 10:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F1E87C09;
	Tue,  6 Feb 2024 11:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="FUoezzxM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BFA87C56; Tue,  6 Feb 2024 11:25:33 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1402E86284
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 11:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f703Ipiwr4I86FXcv+FjqOogSTzuZkl3JFd9enJkjVv4RgQR/5Y6y+v3lCeptYb5Oi0AiGjTdqvO3CC6w681gqY+3l6tdr8hA7jR/rLEynAMpQwAg1QntK5AiwoBROW9BeaTPmofNYCbhRdWnFIBfN+4kAMHhVfOGzoeefYkP9qAF4A8rspZ7ns3ExeK8trY1RVpjvSmpOWHaCVir2puNPPe9BKP6QrS/1f7AMStKGEMFrHwvsgmy5IxELXVAHZKyxiG0AqHvLlE5Cp0cxIzFKhZTYYxM+x6HRlfULxQy5GqL9/kpkBSHS3tJR4D3BH5tXOVLDWjQ6P+wjuseYk7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cx0zXfCepjArk1c24UlBf/GKC+7iBmbchErqSCtSf8=;
 b=VV3k6BplK76ckW2mTqFElO+8se7cm40dSKBstHwnyWU8dx+GdSetAA/p2HPnE5wIDMH3lxv7VTrMGEQeeRmrTS1GvkyloDOnvnf02rOQjacRGV/afK+dSOBn/aoi3gaGZMt6kT0DbhsVHozCgrxFn3HmobcpH6UiVyiG1T0YEd0rlwsV5wuxGcZBzkM+tP0A/7Qcru8kGqA4CDPQOw1O3i3WjBkQtWtnSbr0FGPYriqSvt9tQAn7+nfOxeZMq4BlXkl4UcPayGvSNkLtKgiZBC0QA/GQ0QsCvnVSZf1WYXp7sFnbT0nTpdk7w09/Lje0mSZCVUj0UB0JDj6DSYBOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cx0zXfCepjArk1c24UlBf/GKC+7iBmbchErqSCtSf8=;
 b=FUoezzxMwplDwCzNJhpPcjqPVDyGRrChQkQZSo+QGiP13da1fu3tqc5JWDwftMAN0N4//HAiHKxzIhKhiUHCVUz6SJRlSUpFuFYEqVlDFlfMEDw/ReysOQvkG5pIlHGxl74xBrrjVcbtLk7x4ittT2j0cmdAXiZv432w55AOJpvAxOkgAAiRjnQs4SfWsnhC2bsh1rFVWB7a4/nvnXalBJidFI2m8KxT7+/hn26xcikckVo+hy8vYW0Rpuixv5qLEOFl89TdYvO7hz9ysekM1caZkKlEdIhzvydTA/lOvUoJBVC0Z5atrjICalMXbyTyKLD/dngRdrMJi/8VN6vAZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8894.eurprd04.prod.outlook.com (2603:10a6:102:20d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 10:25:28 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 10:25:28 +0000
Message-ID: <2493a32f-8795-4c71-b719-039db0f0ad24@theobroma-systems.com>
Date: Tue, 6 Feb 2024 11:25:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: dtc-version: Don't show error messages
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, martin@geanix.com
References: <aebd96be57ec59ace348287094ab919ce82711c9.1707191569.git.dsimic@manjaro.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <aebd96be57ec59ace348287094ab919ce82711c9.1707191569.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0110.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::39) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f176db-28b4-480a-3e25-08dc26fdf00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efBq4lJYwGEPoJIQL6EhURTW2wB6uRSVMqD1LTpy0vgh0mCu8e7z9GLJpr9T4jR9cuEMVpnSz+vTMEcH/46wRkKzMzTkGrZWGehOpCy/CiaaqGnHNZ93FWtjjPYO3iF8IJdh+tD1eEeS3EA8qLvI2pANM+2ZVURdZf4uf0zKPHBumHH/lP/Rxq7ifnCwJhRNkGPI6lauwVpeWfSfhAdn9IgdVGRJy42fds6fdtPiqb/qHleu0sSz98PUZKPgtUtExKBd8LYdWPkElo9D3ARGk2Mx78z+TizS5CeGr5qpQsfrDkZsx4xrjOKZh3auVfo0+8Qn2MqLQl7iH7RzVpTFL3Sg4+hTqacy3lL+sZX5/kZetzLrGxB0AkQMRxhTk5s+CJO77e98Ez/Ll2NNEj82ITYvp7j+58enRfB1uP5BW1RUptvHdJWYdMBGk3e/OaY7WEtRGGmi1B0n/iWftPcEXftE2ovScsojmtkw5E6r8aS3d8dNvwX7VrcZhOfCHzRk3Pn+lyoqV8XOEQQuyoksTNw89D2RYgYNT+srcR7VqjItVZCJWPKzOGD6z23aljkaV7MCJ8PcCLfNQ/TzRLldTLco1oNaaM4DmzUP03slbs69uaBiD1iFI3yX34YuYOV3prgnep2SBNSExcZlOidXiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39850400004)(136003)(376002)(230922051799003)(230473577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2906002)(15650500001)(41300700001)(36756003)(31696002)(86362001)(6486002)(8936002)(966005)(478600001)(83380400001)(38100700002)(5660300002)(4326008)(6506007)(2616005)(6666004)(53546011)(6512007)(66556008)(66946007)(26005)(66476007)(8676002)(316002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhSWm94TlFqSnM5OWxBU2xBT2pmVzh2dVNPY2hZUm96UXgrRlQyblB5WGRi?=
 =?utf-8?B?ZGIxdHdsdy9ZUDNYRlRYUzVOdTZacTdnbVZIZ2d1NVo1aEU5c3ljeUpZRXRm?=
 =?utf-8?B?SmhmQ0E3bkRYcTdxeC9GWGtBT3RLazR6TEpTTk9GS0o0b001OXhaNU5zZnhK?=
 =?utf-8?B?Y09XY0pScTdhUTVmeGVtSi9rSGhybHdNamw5Y1RnaG82MTNUb0M3Q0ZuWUtp?=
 =?utf-8?B?eEFwTkErNWNIVUdZUkI2WkxlNVRoVWZ5M3VtZlZteVhsZ0U2SkZFOWljdUVN?=
 =?utf-8?B?eUF5RjFtdkE5S09KbW42YTRCUnhweS91NTZZR2pWMWxWK1YrRU05ZFdnbkcx?=
 =?utf-8?B?akVCbDlYRmlSQUdadDhNbTRyYWFGajJLV0VHb0ExN3RnTXJyN0JuaUtHTlE2?=
 =?utf-8?B?SFQyNGpSU0JyT0lXMHEwV2EvbE8xSkR5OHpGVnFJSlI1YkNTa29EWmV2N2hu?=
 =?utf-8?B?Yi8yakM0eXd4ZlphV2J4Z2pOaFRVOWVtdXhvUWE3VTQrM2l1aGQyNkhESmlt?=
 =?utf-8?B?SmR6NnlFVmpYcG1wVXB0eXpOZVhtNmJEa1NaM3lzeDlMYk1VK09jWkRsakRX?=
 =?utf-8?B?WDRKbUYzVVRIWlBWWmlyYnlONUVrczNZYzBibnJvc1BTWUlOZEsyam5WLzJT?=
 =?utf-8?B?dDJZOTdlWDUvN3d0SHRUYlhnNTJjeWR3c0VGd1FpVUlFSjBvaFlOTjB2R0k4?=
 =?utf-8?B?bGJteU03c2NoNmNySVcvbXdxTm1BMHgrdEMrZnRCdXRwVE1RcndONkhZbEUr?=
 =?utf-8?B?YXBkZk9vYzl5L3R3NWZWTUNsQ3o2TFJjTGJkVkdma1loT3dmUXlTSWZYb2dF?=
 =?utf-8?B?OWlXR1VORDJKdHdUeGV2dmZoalBKaFZaWmhCU2RtYVY1TDRNZGJNNUt5QnhI?=
 =?utf-8?B?Nmg4NlMrRVNwYVFEVHpROVJjaFNSMHl6azR1UHdaWVMrRDNrV2R3OWRXZUVE?=
 =?utf-8?B?dVE5V29ucWJEdnhZSW5GOEl1aCtWaU1YcFlYSVNZdXBMVE9wdnFtVGZMcUNG?=
 =?utf-8?B?aGcxUVBBdEVzd0I5TlNkSWtpVWU2a3NhaFNVeFB3YkJwVVNkNDlKUTNId1hC?=
 =?utf-8?B?NGZ0RlMydWk2ZzByVWJqT0xudGMxbHN1cUU0SkZMTDJNZTUwUW0yL2p2bFlT?=
 =?utf-8?B?TEdFay82aFZYSEJ1S1RTVnR0bDZTc1BJbXRDRWxKbEk3eHd0ZGdKRjI5aDkw?=
 =?utf-8?B?bVdFYWFtdVB0eVpKWFNTbFkzT0JXUmlXMWRCZTlVVzM1YnFxdkk3NkllVEt2?=
 =?utf-8?B?NTJBa1ZYaHM3dUorS1N5K0xiNzN3bkNXRzVNbFZEeEg1ZThNckp1aHF0RUdZ?=
 =?utf-8?B?L002WCtYM0Z5VnBZQ1RTUVR0VHNBanZDZTV1TWc3c1pKRWpwNTl6cWFUTG9Q?=
 =?utf-8?B?VURjVHM1aVMwYTNmS2pUak5qRFlmdDg0VnZxcGpTc3FDekV5VFlaL2M0OEsv?=
 =?utf-8?B?L3Jxejl3NDFFaVdTVnhkT3Z1UlhWTDFCV205Q3QwU1dSTW9IaGpqemxTam5T?=
 =?utf-8?B?cUpoLzJHcC9uSlJOVGVoVzRrbStkZzB3VUZ0cjlpbFMyZU9mZmI5RVVtZG0z?=
 =?utf-8?B?WEZiWmJPN1hjdGxHNkF6Uk1xcGJwY0tRV3pOT0RFVVhVRlYyN2d5ZU9ucXZG?=
 =?utf-8?B?dm9PaEdXNDZPQU5KaGZtYVlZT05vdlBpY0JBQ2M5UUc4eHRkcW5YZ0lQQ1Zo?=
 =?utf-8?B?WEJUSUU5ZUZITHNOTjhHN0ZUbGFMRGJtcjUxS1I0QUJnOHQvRTgycVNwemZ2?=
 =?utf-8?B?bGdseU9RbHRUQitxNHBvMUpTeWZzVWgwMldxME4vbWRDVXdOVTNHa0xrSUk3?=
 =?utf-8?B?azN2ZVVpbGsyZ2hBVzZQWDQ4aWJqc3dhejNaQ1M3L2pZd2JEYTNvcXdRVk1Z?=
 =?utf-8?B?ejRWaXRMU2pCaHptTS9aVExPUnhNdmoxU3p1ZlZ5TG02YTE2amw3MkdOQnBs?=
 =?utf-8?B?UkkySVNwSnZXWDF0VjY1RmprajNBWG1RVElaZXJIbWRRcElVVTlsRVdTUk9z?=
 =?utf-8?B?VVVLNUxRSUZsQ3Nvc0VkSzU1V2pLTDNiWWhqOWVkTTkwR3RaM3RMSFR6OFE0?=
 =?utf-8?B?QlROU1MwdDhrSHM2QkdUaVl4N1RWQWJPQStkT0tOeDMvOVpBOXlTQVlrc2tm?=
 =?utf-8?B?ZG53em9MNlY4QWxvTnBqRXpVM1FPZkxjb0pHTmVoZ0dQZ1lKVS8rcXI0RERx?=
 =?utf-8?Q?x48S1EjroH3/116uPlIqXEI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f176db-28b4-480a-3e25-08dc26fdf00c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 10:25:28.4968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbElIwVyROZdl7qyTzKEEI6nX+Nne+Zy++rBkLe5FNQxqY8fpifAsxf/tkP4LkFwIlRT/7DeeE1/edWeNIN5MeY3B3rk9H1J/DgzHCGEw1S680gply6qLM/nIYvhDRDq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8894
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

Hi Dragan,

On 2/6/24 04:56, Dragan Simic wrote:
> [You don't often get email from dsimic@manjaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Prevent the error messages produced by which(1), such as the one quoted
> below, from being visible in the build outputs.
> 
>      which: no dtc in (./scripts/dtc)
> 
> This makes the build outputs look a tiny bit cleaner.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>   scripts/dtc-version.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc-version.sh b/scripts/dtc-version.sh
> index 53ff868bcdce..6d3d7b68fdfa 100755
> --- a/scripts/dtc-version.sh
> +++ b/scripts/dtc-version.sh
> @@ -15,7 +15,7 @@ if [ ${#dtc} -eq 0 ]; then
>          exit 1
>   fi
> 
> -if ! which $dtc >/dev/null ; then
> +if ! which $dtc >/dev/null 2>/dev/null ; then

What about

which $dtc > /dev/null 2>&1

instead?

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
