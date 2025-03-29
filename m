Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4FCC36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 12:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5AA1800C1;
	Sat, 29 Mar 2025 13:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cd5eM+bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5753D80079; Sat, 29 Mar 2025 13:02:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABCE4800C1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 13:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1743249734; x=1743854534; i=xypron.glpk@gmx.de;
 bh=d5qWqhGjd64CefmshIqHVudz89ehmv8CgqVOiRNp56w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cd5eM+bgTH0jl5s9+ZdNUIXr1gv2twhb4wAge7rgj+/mbqaeWVl1JGDSJZr4qj99
 LUqGr26TFSB8mrjYSx7SFz6MRnjwdi6AzoqfgKtv7eGZVCjV1dyKJHUCmir06F2Pm
 OfMqPqPfCjxS+u98KWafpM53D7h8Pl9MhKdwneNApxBHADCdV7se7tKDNtXRTQ2Vz
 UlLLEKYUfOCTNv1T69Wlgv6dnnVH2fpyUCx/bf6UZ8ASuzBQ3mnHXFFfohGjhrT8y
 9BotXV0hsYIYUm/7WuX1AJLCQj1zhNb06D9StKP/TCY5RVNvJ4sTUs0CtRAN0mHOG
 CTRRAhgnqKAxQ2yyQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1tLrIY2Zoa-00Zl0G; Sat, 29
 Mar 2025 13:02:14 +0100
Message-ID: <92f8a810-981b-4ad7-9a6b-be013ccf084e@gmx.de>
Date: Sat, 29 Mar 2025 13:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
To: Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20250326054653.273906-1-quic_varada@quicinc.com>
Content-Language: en-US
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 EABachinin@salutedevices.com, jerome.forissier@linaro.org,
 rasmus.villemoes@prevas.dk, ansuelsmth@gmail.com, sughosh.ganu@linaro.org,
 michal.simek@amd.com, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250326054653.273906-1-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LkU42vv7BLnAKT9dNU0k5yPnayHYbeghCmI2bbsqJN5uoRvI7mE
 VhIW7LzUszf5LET6n3ECT1BkvtJ60yAKYyvvM2aDoGcow1yIf1n5/n/fv2Y0bHBwXPN3XoJ
 SHLfREmBNVoT57mrPQdvLEyNMDLuCts30tZeX+5DwyMzybU7yB2/Sqq5W3QPbB3fHdgchbQ
 RBZfvoZf+Y9F86OW+PMlg==
UI-OutboundReport: notjunk:1;M01:P0:VH3tGEdUo4w=;VP3eV2M8pZMttY0MATPi/QR4TXo
 8y+PxNbaBzACp4hK1uD9z+/GtcyBS0Ct/13Qc5PsGGHmuvDCg4BeMBFnRzGUusHDwUvBHvVRK
 XvnqBkJa0jSqFaj3yXTgtViPcawvNCBfSz0OzIreh/NIVkn384SOX/9JM72epwrulOiNwJqLE
 KGt71cSVcqLJRw/x26eIiBiQvpkvbyH+WjSI0SN0iMIhSmxT4MUKzjTVMXDS0P/KwLa2OCbey
 qnro811zC6WqWCQEIBsRGtdmrsJENTR7bbGSBDZKv0tTp6HIsx/bPgun9b6Ff68mlNl0yV6cL
 I6OAq/ewAVSgF3bVJcN6Ttr5J7AMOIIwemjGwoeF4WHkxaK1r817PWyOCOKZo8hwr7ljSAA0a
 l4ZvbdDKlGwzUiKz4HG5ZkigTAchrZme7wnFMZGIxa8IzZBdtSZzvJeENUEQdn6/CGvcUOqQg
 lugxoVt/vWwM/FHt01Hl6NdiNOHg3DhZYyLsNxqdn7GOeojMOp05cWBDP5dAxrsnV7f5hMZ/m
 0/QkwcjxuZ+zQeJev/IsqAmPt/Ku66VbK+LxYsIqWPSxLF4VdJTRYF2JTHubluqwWGGI55lL8
 jZZGYrkw88nn3WcAn4e+vGQQme8K4X7y06xLVxSlL0x4OSc6GRkYqlNGqqQ3CRqU1caVLqhz4
 /+aRsjkF5BmNMEYgWOG9AUnMFHxrd3TrHpsF3WqhIQJiyGs6z8F0TM8MQ8TqF/ve7dpkkDZSl
 /VLifR74/GH34JqOJIsQqrPgf5eIsH7jtWnssn08j1KuskQylmyBMwqvWvTNRgK3w+y7ZkhDK
 YzNv8ge1eXmRtGS5kCUDb9/WZi+rRVhONcH91RzkuZwuG9gDzE7aJTf4K4F2bhDpuYwyywwPR
 MdmffRdKbMw8FV0tpLCtuvmMR9hEqDD9XTJminR4pdaefKp6YVN81GKDP7Mm/GNI/8mYIATbB
 C3SU2glVdulIHKqNOKTdXp8TNc7Y4hpt9qcQZVvMdhuY9WcLiYIlQwbB2BoJSl8/zgpIq4AjP
 B4Ef+AJlP6iVmgmUAojdVlwRujiPsqIvipnnoTi+wOCQ3h47/T1OO6BFeLVqVqKoqMtwBbVAn
 tBKksA/HTkuAL0EiU4ZdK2f30K7NTN5c9aZRfVj3tfqQgVUrr8+6sDfR23HYECEi4+CTnGVZ6
 elFHr7FkwE/6HMZiIQ3RrnAJ5UzNqX2PKMg5vyAWpDrP0pxzZNAnTLJpR4yEsa3+wc0sQTHOL
 84gX0ULBqXhfQH2oubLj/2EPrIrH1eDPwIYpJ+SUZrAkQONUPIuJiXzbJsaJBZO53pBoQLumn
 vy7O12ZPVanIp0lPkCZaI9iKaxIRTQ1h84MIjl0uUehUmJ6OAND0vL8zAhpHe4G6t/D/kUHXM
 jKyv9qsvStyYRKqUrSYeE27QMySuRXoTXcqGvZu/icqFWtYvBrVZxVZsG9orjfsTy7m6ySRkB
 G7upl0Jfs/ziLClR3O7/yLbSVkFE=
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

On 3/26/25 06:46, Varadarajan Narayanan wrote:
> If the EFI runtime services pointers are relocated even though
> relocation is skipped, it corrupts some other data resulting in some
> unexpected behaviour.
>
> In this specific case, it overwrote some page table entries resulting in
> the device memory address range's mappings getting removed. Eventually,
> after the completion of efi_runtime_relocate(), when a driver tries to
> access its device's registers it crashes since the mappings are absent.

Hello Varadarajan,

thank you for pointing out this issue.

I found two places where the flag is set:

lib/efi/efi_app.c:198:  board_init_f(GD_FLG_SKIP_RELOC);
board/synopsys/iot_devkit/iot_devkit.c:117:     gd->flags |=3D
GD_FLG_SKIP_RELOC;

iot_devkit_defconfig does not support UEFI.


lib/efi/efi_app.c:198:  board_init_f(GD_FLG_SKIP_RELOC);

efi-x86_app64_defconfig does not support UEFI either.


For existing boards this seems to be a non-issue.

>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   common/board_r.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 179259b00de..1dd3b96c2de 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
>   	 */
>   	efi_save_gd();
>
> -	efi_runtime_relocate(gd->relocaddr, NULL);
> +	if (!(gd->flags & GD_FLG_SKIP_RELOC))
> +		efi_runtime_relocate(gd->relocaddr, NULL);

efi_runtime_relocate() is called twice:

* when moving U-Boot to high memory (that is here)
* when the OS call SetVirtualAddressMap()

Removing the call here looks like the right thing to do when main U-Boot
is not relocated.

Did you test that starting an operating system via UEFI works in your
use case?

It would be preferable to have a QEMU based defconfig where we could
test this scenario and add it to the CI.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


>   #endif
>
>   	return 0;
>
> base-commit: 244e61fbb7f5045e4e187024f7ae80434c952145

