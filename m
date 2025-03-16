Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAA2C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 14:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C93D180F4C;
	Sun, 16 Mar 2025 15:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="LFCrtH1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A880810E8; Sun, 16 Mar 2025 14:25:43 +0100 (CET)
Received: from send219.i.mail.ru (send219.i.mail.ru [95.163.59.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5623C80C93
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danila@jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
 ; s=mailru;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
 :Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=fe8mKMnGVhrlcjohbqL/w18UZGU2bj4pjg9YX6GzKko=; t=1742131539; x=1742221539; 
 b=LFCrtH1xFQF7eH93E8u0g7PHG8YtpCExeBeQNDmPxxejel85d2YRnD+0oeI+oBUx82pEkWs+IQF
 e+rljeHPs/R1zIumyTLy6panpJ2Ky0eAYIKusUrONoxT5G8ARMnGBF2YUvN9vW1RvjfhAuYRl84Wm
 fFY/4hCKOtwQq2spXqU=;
Received: by exim-smtp-69cc44787d-2vhx7 with esmtpa (envelope-from
 <danila@jiaxyga.com>)
 id 1ttnzk-00000000ETQ-3PtA; Sun, 16 Mar 2025 16:25:37 +0300
Message-ID: <378f742a-c1ea-4838-9e1a-fd76065bf026@jiaxyga.com>
Date: Sun, 16 Mar 2025 16:25:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Better smartphone support (Qualcomm)
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
Content-Language: en-US
From: Danila Tikhonov <danila@jiaxyga.com>
In-Reply-To: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-69cc44787d-2vhx7;
 auth=pass smtp.auth=danila@jiaxyga.com
 smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9CB00722163A93FBBAB85831366797FE166D9977BEE8C9328CD62213F67905E7A92BAD2758376855F912804B892A32FBE0EC248D3F6F07FF947831E9195C77D5D51CE0648C9E8651D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7850A3F981F25E362EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375665A3E9B1844DE945983BF947831A17F67748F875C93D685F40576CCF9B0F8B4EC389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0A29E2F051442AF778941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6F459A8243F1D1D44CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C2249F4CAD2F895B8664376E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B4D348A69CAB14DA63AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E7351CE60B8040019C36C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A51A54E5020D027F6F5002B1117B3ED69691DF33AD1DF825B5B48B7A7F94616420823CB91A9FED034534781492E4B8EEAD220496FFA5CD4785BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34C6EC1BD9807109D263E4C97F1A9D04D280424C1891F76837E6DD1A9B39C0CC98D5EDBB99718DA0EF1D7E09C32AA3244C0C0D27548FE137E877DD89D51EBB7742941F42F7BE132579EA455F16B58544A2E0521520D7E397DD2F5917587EE62550FD86509DC4BCF188543BAAEF129339B02BD3E44DE9B469C4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVRxnlmV4XzQl9oIyC9UFT50=
X-Mailru-Sender: 9EB879F2C80682A0D0AE6A344B45275F84543A45B49A2708CC811723C208B4170F974917A0D66FA23D5CDFC6B044FCFE2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Sun, 16 Mar 2025 15:10:58 +0100
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

On 3/11/25 15:31, Caleb Connolly wrote:
> Improve support for running U-Boot on [Qualcomm] smartphones, with:
>
> * A boot menu which can be entered by holding power during boot
> * Hang on panic (so errors can be read on the display)
> * Serial gadget which can be enabled by holding volume down or via
>    boot menu
>
> In its current form, U-Boot's boot menu is perfectly adequate, however
> once an option is picked U-Boot will never return to the menu, always to
> the CLI.
>
> On a phone (with no keyboard), dropping to the CLI effectively makes the
> device unusable until manually rebooted, since there is no way to run
> any commands...
>
> To rectify this, let's revive CONFIG_BOOT_RETRY for the hush parser and
> add an option CONFIG_RETRY_BOOTCMD to run the contents of "bootcmd".
> This provides for a flexible menu system which we can enter and exit.
> See qcom-phone.env in patch 1 for more details.
>
> Finally, provide some rough-ish documentation to describe how Qualcomm
> phone support works and outline some debugging steps for when UART and
> the framebuffer are unavailable.
>
> ---
> Changes in v3:
> - Minor wording/clarification improvements in docs
> - Introduce CONFIG_RETRY_BOOTCMD rather than changing the default
>    behaviour.
> - Enable some more gadgets in the phone config fragment.
> - Link to v2: https://lore.kernel.org/u-boot/20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org
>
> Changes in v2:
> - Fix CONFIG_BUTTON_REMAP_PHONE_KEYS name in qcom-phone.config
> - Add Tom and Simon to CC
> - Link to v1: https://lore.kernel.org/r/20240831-qcom-phones-v1-0-08614edd8e35@linaro.org
>
> ---
> Caleb Connolly (4):
>        board/qualcomm: introduce phone config
>        cli_hush: support running bootcmd on boot retry
>        bootretry: check for bootretry variable changes
>        doc: board/qualcomm: describe phone support and bringup
>
>   board/qualcomm/qcom-phone.config |  17 ++++++
>   board/qualcomm/qcom-phone.env    |  49 ++++++++++++++++
>   boot/Kconfig                     |   7 +++
>   boot/bootretry.c                 |   2 +
>   common/cli_hush.c                |   6 +-
>   common/cli_hush_upstream.c       |   6 +-
>   doc/board/qualcomm/board.rst     |   5 ++
>   doc/board/qualcomm/index.rst     |   1 +
>   doc/board/qualcomm/phones.rst    | 122 +++++++++++++++++++++++++++++++++++++++
>   9 files changed, 211 insertions(+), 4 deletions(-)
> ---
> base-commit: 78f8c8c58f7d3f7c3a26af4afbd08aba21c14c90
>
> Caleb Connolly <caleb.connolly@linaro.org>
>
Thank you.

Jens shared the image so I could test your series on Google Pixel 4a and
it works.

Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish

Hopefully we can test SM7150 GCC/PINCTRL for sd-card and send these
drivers soon.

---
Best wishes
Danila
