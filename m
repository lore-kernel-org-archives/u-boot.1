Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5333C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2026387A00;
	Thu, 18 Jan 2024 08:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IODlxWOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D6C87A77; Thu, 18 Jan 2024 08:30:50 +0100 (CET)
Received: from mail-m12796.qiye.163.com (mail-m12796.qiye.163.com
 [115.236.127.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36F787837
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IODlxWOii1kWHQB/Qy1FPJkk2xg0+CQJ4yuB0r8ighHcl9B1/MJbqBdMGnEDBAtnF3LMGSo8FbduY04dlN6JTLkD5cmnOo2Oel1uQsMaf9h2XmzsvbdkIHg8CtHGl3ljze9KJ8YbHAVjrOXsPQNdStKnkOxx6DJ77nex7vDj6G4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=X3JKBO+0aWGlPRRfqZY56dqlOBColiUamvW20p262CE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id C5B84900402;
 Thu, 18 Jan 2024 15:30:43 +0800 (CST)
Message-ID: <2cfa0648-8932-41bc-8d88-02859ebb0648@rock-chips.com>
Date: Thu, 18 Jan 2024 15:30:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 7/7] doc: board: anbernic: Update rgxx3 to add new
 boards
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: andre.przywara@arm.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jagan@edgeble.ai, jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
 <20240102154654.191055-8-macroalpha82@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240102154654.191055-8-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMeTlYaT01ISx4dTkgYSkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b7ab8912eafkusnc5b84900402
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODo6CRw6PTwdCBAaITAQCEIX
 QhhPCTRVSlVKTEtOTk1IS09PTklPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSkhDNwY+
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


On 2024/1/2 23:46, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Update the RGxx3 documentation to note that it now supports the
> RG-ARC-D, RG-ARC-S, Powkiddy RK2023, and Powkiddy RGB30. Also update
> verbiage around panel detection to note that it is no longer hard coded
> to the RG503.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   doc/board/anbernic/rgxx3.rst | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/doc/board/anbernic/rgxx3.rst b/doc/board/anbernic/rgxx3.rst
> index 7d1beb423c..d159ed2f76 100644
> --- a/doc/board/anbernic/rgxx3.rst
> +++ b/doc/board/anbernic/rgxx3.rst
> @@ -5,6 +5,8 @@ U-Boot for Anbernic RGxx3 Devices
>   
>   This allows U-Boot to boot the following Anbernic devices:
>   
> + - Anbernic RG-ARC-D
> + - Anbernic RG-ARC-S
>    - Anbernic RG353M
>    - Anbernic RG353P
>    - Anbernic RG353PS
> @@ -12,18 +14,24 @@ This allows U-Boot to boot the following Anbernic devices:
>    - Anbernic RG353VS
>    - Anbernic RG503
>   
> +Additionally, the following very similar non-Anbernic devices are also
> +supported:
> +
> + - Powkiddy RGB30
> + - Powkiddy RK2023
> +
>   The correct device is detected automatically by comparing ADC values
>   from ADC channel 1. In the event of an RG353V or RG353P, an attempt
>   is then made to probe for an eMMC and if it fails the device is assumed
>   to be an RG353VS or RG353PS. Based on the detected device, the
>   environment variables "board", "board_name", and "fdtfile" are set to
>   the correct values corresponding to the board which can be read by a
> -boot script to boot with the correct device tree. If the board detected
> -is not of type RG503 (which currently has only 1 panel revision) a
> -panel detect is then performed by probing a "dummy" display on the DSI
> -bus and then querying the display ID. The display ID is then compared
> -to a table to get the known compatible string for use in Linux, and
> -this string is saved as an environment variable of "panel".
> +boot script to boot with the correct device tree. If a board is defined
> +as requiring panel detection, a panel detect is then performed by
> +probing a "dummy" display on the DSI bus and then querying the display
> +ID. The display ID is then compared to a table to get the known
> +compatible string for use in Linux, and this string is saved as an
> +environment variable of "panel".
>   
>   FDT fixups are performed in the event of an RG353M to change the device
>   name, or in the event the panel detected does not match the devicetree.
