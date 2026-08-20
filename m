Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47CCC5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 16:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20BDA60648;
	Thu, 20 Aug 2026 16:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsCDUqoffC4x; Thu, 20 Aug 2026 16:29:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787243356;
	bh=+wlqT8w6Vas3uCYo45Mk1fi2YyHznGWscnoyg3SGsFk=;
	h=To:Cc:From:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IRAdx7KFyLGqupoitUIHZ+PfPjH3PawQ3gbAIyG+VoAYwUoluLF8/+s+PCDn4lbEL
	 O69H3fhJCZSm9nz/izg2ZsQwz0kQYjUCXKE5gOIUxrtnjZs07PpZ7tN55NYi0BCPW0
	 gb0HEbrrajc/qfT4qExWRLuMg0N0Gw9yOO32Ig7s61Ii4DBUfijGc0K+5alNhjIzFH
	 b5V+AqmhIzNTndrTHduxdMaGfwyJ88VmnlCdxT82utsPbvT6lOoh7hz5qxcfn0PnFe
	 jwwOdV2HO20BpNnH9HiS2+ze3yMzoXHIl0ZdnNIQuBQvY4mihDdIcxODCLxxJwJLMu
	 Y26iRvF1helWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1683C606C2;
	Thu, 20 Aug 2026 16:29:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA62729D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 16:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBC5A606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 16:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihxaKe5CSNBl for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 16:29:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3006:206::45; helo=outbound.qs.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=qoOglXTq
Received: from outbound.qs.icloud.com (qs-2004g-snip6-6.eps.apple.com
 [IPv6:2a01:b747:3006:206::45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D686060648
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 16:29:13 +0000 (UTC)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 D85D4180013D; Thu, 20 Aug 2026 16:29:09 +0000 (UTC)
X-ICL-RepId: 01a02001-4734-775a-85ef-355d854bafce
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YCXwBLVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEATBVIHXU1WDUcPWB5cFBcJQENeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAQ8AXQQUXxoeDlVYUV0NGVUIGlMHEVpVUVwDDgNCXElQDAUIch1cVlACWlUSBEAIVlBeCF4fTBw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1787243352; x=1789835352; bh=+wlqT8w6Vas3uCYo45Mk1fi2YyHznGWscnoyg3SGsFk=;
 h=To:From:Subject:Date:Message-id:Content-Type:MIME-Version:x-icloud-hme;
 b=qoOglXTqtCRCNqdzmvkfCmGHH1+wX84T5ZYqZJekr7ZUg69J9xyq0wZ0vpIbIIfuRrw/JB5pxlQ3f5xoERaRcincgsVDN1z+1Ass7tqTURjXv4EIE1fr8iZrslqFYgNk3ZVTFHHezyQul1DAO8/Go9wltWdEx6S7nJYfq4wNNdcEO1mqklpAjmKNhV5meQtG0KUEcyICphMTYbLkwRn1h/O+MtOYMUEI7+xTs+ujcGD5osMbZ4OKwPrbME+e6tuJ37TlTdW5n76NGMz9/Hd2wLHO3fvS3P4FwmpcEohbGt90lOIxQqNcpI3a/HtZfnUs+OJM2ST8IonJaYIvPlYQPA==
Received: from p00-mailws2-7c9f864df-88gsq (unknown [10.112.113.19])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 315E9180021C; Thu, 20 Aug 2026 16:29:09 +0000 (UTC)
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, kever.yang@rock-chips.com, sjg@chromium.org,
 jbx6244@gmail.com, jonas@kwiboo.se
From: =?utf-8?B?5YiY5Z6j6L6w?= <valentinliu@icloud.com>
Subject: =?utf-8?B?UmXvvJpSZTogW1BBVENIIHYzXSBhcm06IHJvY2tjaGlwOiBzcGw6IEFkZCBo?=
 =?utf-8?B?b3RrZXkgZGV0ZWN0aW9uIHN1cHBvcnQu?=
Date: Thu, 20 Aug 2026 16:29:09 +0000 (GMT)
X-Mailer: iCloud MailClient2630Hotfix39 MailServer2612B5.952a5ad53a12
Message-id: <2b766dfb-cb3c-4afe-85ac-b14e12e1ca2c@me.com>
Content-Type: multipart/alternative;
 boundary=Apple-Webmail-42--b3d78300-66bd-465e-904c-9714973bf5e4
MIME-Version: 1.0
In-Reply-To: <ca2da16f-1c21-4c39-b1da-03ed30e9a0de@0leil.net>
References: <20260815183437.7387-1-valentinliu@icloud.com>
 <20260818165526.764686-1-valentinliu@icloud.com>
 <ca2da16f-1c21-4c39-b1da-03ed30e9a0de@0leil.net>
X-Proofpoint-ORIG-GUID: qXeBLe5OthTPG4IpbA1F2RjQP_JJqEap
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNCBTYWx0ZWRfX1ske0N/CSDli
 RWGAMMkSYzk+rHw4IMAT1j1Gu43ELm+xeJi04Rqm3HwLExq0aO1MVGsVVjvWfwaaMUC8YISP60g
 xv8kKmu09oXWLUle7BqM6P8Joy4gEEy6a7J2SE1ffx5gL5VcBTHCWVPR3eZ13x1ZP4lZoQ0EXHO
 FT5uGkOv9nUs+OQ8LrKBA1DfLbncCCQ6rxHhTPFsdJOy6oT9wQ6u3QPRejSLDjWU4lXk96kBNRc
 xXPDw+wPa0Z0LZUF6vbZB03DibTd3Xh0cp7ca519GAXaWtxmQPhOi6Ux9suWGQVWCT7Wh/Oy7dQ
 r8U4RCVO+vZekgBDP8q3q5EF4mynKxJPUqnOJQkKE7V4XeS7u4LEXjgN44BarE=
X-Proofpoint-GUID: qXeBLe5OthTPG4IpbA1F2RjQP_JJqEap
X-Authority-Info-Out: v=2.4 cv=R5sO2NRX c=1 sm=1 tr=0 ts=6a872b56
 cx=c_apl:c_pps:t_out a=w0vwr1DNSLjGex3smDq1Tg==:117 a=Sv0fKeRqtYgA:10
 a=5KLPUuaC_9wA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LQAHsTbMm04A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7copsteyAAAA:8 a=v3ZZPjhaAAAA:8
 a=tqVgM4YWDJBVsEitlzgA:9 a=QEXdDO2ut3YA:10 a=3U6nK4pU1x26c_a5:21
 a=_W_S_7VecoQA:10 a=np33tI3PdIrD0yRJz6Tq:22
X-JNJ: AAAAAAABd/i8mlI6IbSuoYKFT7wC+Bz9JQlA7Br/sT5pRwHJfniE+SrKACibz603IkU0zIceNaD8MXZESbWYv4YlmD5pffz/h1VGd/rCTi3rmvt9/i6K1xOkK2bB8PoAvtyq+Kjhrgi1zEq99/mznhRNMxhQ3Q5cTOlONYc0QUWUzxJpzMQXg4u7wODgu0vx70+EkprQFEH1t+KIszT6uC2d5V9sQAv7eQywDJ6LNlIEIhv8UcN4GBWneMBb6FXyr8yGVO28fQdpHQSU0n0iom35aImPXMtVWtAUdI0h1H3+5N5poGO9MmywsdATy5Riq/3fuqw5f3RB5puJuraoBDR7er1+gSuMC2M3Sxeo+znb+kaAIJ9RBNVWtp53+U5+zO3G86yQlLruCaQ2BkaGjY2uCNHHKWYseXLEkBVuyDKHosW9EtKo1488U6Rtvo5p9mBiCq/Hh3BfXyVPnJyW3YaBvYfje7WWPe3yQnO93y7VHPPp0GK5O1QcHWsn2MlkUqavbJrh12FfP+SQ66Lh495MOk0nUYD5JVZBwv0Y+HLh2XhMJpsn2Og72ouz/njY+V4NaoMCM04vvb3+HSNrqqZTbLunBI5QtTC0+vE8sn+DrpkID3W62o2DUI0nMGQLF2PRyICTNyiLg85pX8ofPyoc9v5m5Qudv2mrCQPMW9Jb3xObOeCg2NsZRpWejRV63SZUwL6Ef1676j5znbX4MDCdiaFRsDGYANcWlTyHvjwc5Ki+d4+w9xuAk/Pbc6rc95JFtBT8BMSuq3kNeFRijJc4lFBYyyVDi0gjIU09Mr1CTDrOqGttg5raLYXL3+PFZ+b0SZ49wF/6lYMGPgQ2jR1lJ1fZOfgOHRDFSBgkAhIx6OVvDUgotn37Vs2VjHXAi96gjo9JoOMIztWJWxeOB5pe+vf1IHxInhufqC7lu+ynIrg1SlotiPudw0BmP75DDQf2hPh9wg5t35CBVoEQpMoGibleOi4
 Y9B7jaclHZuMgRj3toKHSXMMHOHU809tsn1Q5W3rXSsnc9Ab7cNfWN7LZhJWVpJwv8s8HEvzNqKED1swJc3P9d8sXrgTjQNe5n7PYRITfdmT5pWYVP75we1rWS1DM8Dowr7LrzJDG2Vrpo7Jx080H6DPi9fhuZkqYink/kpnHckP60sVwO1kpg2i+Frgz7YCMxz8CwLwFbMEVK8vDmM2gZ1YTkQhbOstg7srFm958ZFua53AwGgRxvkbJaG5RH5X9+C8EsWTLK7NQjeexaY1FyB6MVHO30SscSf7nTZa971Kq7mir+zva/WCKMlYA0aLATdOo4NMx6tz0MZV17nllAg724F/FSQ7+IzPZjuBfyHMMQWk3Iz5iarbqO01M81CHNaEaTKxoHd8/qKnXehlOjn+eMUhFQRfUiokfdvTu1cwdmAx9rQGRn+DSBy3E9p/P
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--Apple-Webmail-42--b3d78300-66bd-465e-904c-9714973bf5e4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
    charset=utf-8;
    format=flowed

Hi Quentin, Thanks for your reviewing and suggestions. I think the config =
name shouldn't be changed to " SPL_ROCKCHIP_ENTER_MASKROM_ON_KEY ". Becaus=
e this function is aim to provide a way to enter the MaskROM, Loader and m=
ore mode (supported by Rockchip chips directly) in SPL by pressing hotkey =
(like Ctrl+B, Ctrl+D) in serial. This function is dependent on a working s=
erial port and not dependent a physical button. About merging code to rock=
chip_dnl_mode_check() and same places: The SPL hotkey support is aim to pr=
ovide a way to enter MaskROM and more mode without ADC keys support. That'=
s meaning we didn't need a physical button in board to enter MaskROM. Abou=
t delay 100ms: I have tested this function on my Mekotronics R58X-4G board=
, this is the shortest time that the hotkey can be detected. (Even though,=
 I still need to press Ctrl+B before SPL running) Sorry for my poor Englis=
h, I'm trying my best to describe the function of this config in Kconfig. =
The other suggestions have been accepted in v4 patch. Like checking CONFIG=
_ROCKCHIP_BOOT_MODE_REG, adding a small comment. etc. Best regards, Valent=
in Liu 2026=E5=B9=B48=E6=9C=8820=E6=97=A5=E4=B8=8B=E5=8D=8811:38=EF=BC=8CQ=
uentin Schulz <u-boot@0leil.net> =E5=86=99=E9=81=93=EF=BC=9A Hi Valentin, =
On 8/18/26 6:55 PM, Valentin Liu wrote: Add a configurable Rockchip SPL ho=
tkey feature that checks the serial console during SPL startup. Ctrl+B can=
 be used to enter BootROM download (MASKROM) mode and be widely used. We c=
an add more boot mode support in future. Add CONFIG_SPL_ROCKCHIP_HOTKEY to=
 enable the feature and wait for the serial port to be ready to receive in=
put before checking for hotkeys. Signed-off-by: Valentin Liu <valentinliu@=
icloud.com> --- Changes for v2: - Simplify the dependencies of SPL_ROCKCHI=
P_HOTKEY. - Remove the conditions for the newly added includes. --- Change=
s for v3: - Add a dummy spl_hotkey_init() to avoid undefined reference err=
ors when building without CONFIG_SPL_ROCKCHIP_HOTKEY. arch/arm/mach-rockch=
ip/Kconfig | 13 ++++++++++ arch/arm/mach-rockchip/spl.c | 44 +++++++++++++=
+++++++++++++++++++++ 2 files changed, 57 insertions(+) diff --git a/arch/=
arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig index 1a2e7847c=
9e..f2d2b5520ef 100644 --- a/arch/arm/mach-rockchip/Kconfig +++ b/arch/arm=
/mach-rockchip/Kconfig @@ -743,6 +743,19 @@ config TPL_ROCKCHIP_EARLYRETUR=
N_TO_BROM config SPL_MMC default y if !SPL_ROCKCHIP_BACK_TO_BROM +config S=
PL_ROCKCHIP_HOTKEY + bool "SPL hotkey support" The symbol name and prompt =
is not clear enough on what it does. config SPL_ROCKCHIP_ENTER_MASKROM_ON_=
KEY bool "Enter MaskROM on key press during SPL" maybe? + depends on SPL_D=
M_RESET && SPL_SERIAL + help + Enable hotkey detection during SPL booting =
stage. + + When enabled, SPL checks the serial console for a control + cha=
racter and can execute Rockchip-specific hotkey actions, + such as enterin=
g BootROM download mode (MASKROM) with Ctrl+B. + + The hotkey is checked a=
fter the SPL console has been + initialized. + Simplify to: """ When enabl=
ed, the SPL will check whether Ctrl+B is pressed and enter MaskROM in that=
 case. """ config ROCKCHIP_SPI_IMAGE bool "Build a SPI image for rockchip"=
 help diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/s=
pl.c index e989c148079..0bcfb42c306 100644 --- a/arch/arm/mach-rockchip/sp=
l.c +++ b/arch/arm/mach-rockchip/spl.c @@ -13,11 +13,14 @@ #include <log.h=
> #include <mapmem.h> #include <ram.h> +#include <serial.h> #include <spl.=
h> +#include <asm/arch-rockchip/boot_mode.h> #include <asm/arch-rockchip/b=
ootrom.h> #include <asm/arch-rockchip/timer.h> #include <asm/global_data.h=
> #include <asm/io.h> +#include <linux/delay.h> #include <linux/bitops.h> =
DECLARE_GLOBAL_DATA_PTR; @@ -107,6 +110,44 @@ __weak int arch_cpu_init(voi=
d) return 0; } +#if IS_ENABLED(CONFIG_SPL_ROCKCHIP_HOTKEY) Please use CONF=
IG_IS_ENABLED() instead. +static void rockchip_reset_from_hotkey(const int=
 code) +{ + switch (code) { + case 0x02: Please add a small comment after =
0x02: to specify which key combination triggers this code. E.g.: case 0x02=
: /* Ctrl+B */ + printf("SPL Hotkey: Ctrl+B: BootROM download!\n"); Please=
 be consistent with what we have in arch/arm/mach-rockchip/boot_mode.c, th=
at is: "Ctrl+B pressed, entering download mode..." I don't like it, as it'=
s typically called MaskROM, but it's something we can fix later on and I p=
refer being consistent with what we currently have. + writel(BOOT_BROM_DOW=
NLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG); We *really* shouldn't be doing this=
 if CONFIG_ROCKCHIP_BOOT_MODE_REG is 0 (the case for most boards). + do_re=
set(NULL, 0, 0, NULL); + /*NOTREACHED*/ + default: + if (code <=3D 0x1a) /=
* 'z' */ + printf("SPL Hotkey: Ctrl+%c\n", code + 'A' - 1); + else + print=
f("SPL Hotkey: Unknown code: 0x%x, ignore\n", code);> + }> +} + +static vo=
id spl_hotkey_init(void) +{ + if (!gd || !(gd->flags & GD_FLG_HAVE_CONSOLE=
)) + return; + if (gd->flags & GD_FLG_DISABLE_CONSOLE) + return; + + /* Wa=
it for the serial port to be ready to receive data. */ + mdelay(100); + Is=
 it not ready by the time we call this function? How did you come up with =
100ms? + if (serial_tstc()) + rockchip_reset_from_hotkey(serial_getc()); +=
 else + printf("SPL Hotkey: No key pressed, continue\n"); We don't need to=
 print on the standard path. If you reaaaaaaally want to have something, t=
hen use log_debug/debug instead so it isn't printed by default except if y=
ou build with debug logging enabled. +} +#else +static void spl_hotkey_ini=
t(void) +{ +} +#endif + void board_init_f(ulong dummy) { int ret; @@ -143,=
6 +184,9 @@ void board_init_f(ulong dummy) } #endif preloader_console_init=
(); + + if (IS_ENABLED(CONFIG_SPL_ROCKCHIP_HOTKEY)) + spl_hotkey_init(); C=
an we merge with the very similar logic we have for an ADC button in arch/=
arm/mach-rockchip/boot_mode.c instead? I believe it makes more sense to ha=
ve everything capable of entering MaskROM mode in the same place, with the=
 same logic. I could see an else if() block in rockchip_dnl_mode_check() f=
or example. Cheers, Quentin
--Apple-Webmail-42--b3d78300-66bd-465e-904c-9714973bf5e4
Content-Type: multipart/related;
    type="text/html";
    boundary=Apple-Webmail-86--b3d78300-66bd-465e-904c-9714973bf5e4


--Apple-Webmail-86--b3d78300-66bd-465e-904c-9714973bf5e4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
    charset=utf-8;

<html><body><div><div>Hi Quentin,</div><div style=3D"font-family: &quot;SF Pro Text&qu=
ot;, system-ui, sans-serif;"><br></div><div style=3D"font-family: &quot;SF=
 Pro Text&quot;, system-ui, sans-serif;">Thanks for your reviewing and sug=
gestions.</div><div style=3D"font-family: &quot;SF Pro Text&quot;, system-=
ui, sans-serif;"><br></div><div style=3D"font-family: &quot;SF Pro Text&qu=
ot;, system-ui, sans-serif;">I think the config name shouldn't be changed =
to "<span style=3D"color: rgba(255, 255, 255, 0.98); font-style: normal; f=
ont-variant-ligatures: normal; font-variant-caps: normal; font-weight: 300=
; letter-spacing: -0.37px; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; white-space: normal; background-color: rgb(28, 28, 30); text-d=
ecoration-thickness: initial; text-decoration-style: initial; text-decorat=
ion-color: initial; float: none; display: inline !important;"><span class=3D=
"font" style=3D"font-family:&quot;SF Pro Text&quot;, system-ui, sans-serif=
"><span class=3D"size" style=3D"font-size:17px">SPL_ROCKCHIP_ENTER_MASKROM=
_ON_KEY</span></span></span>". Because this function is aim to provide a w=
ay to enter the MaskROM, Loader and more mode (supported by Rockchip chips=
 directly) in SPL by pressing hotkey (like Ctrl+B, Ctrl+D) in serial. This=
 function is dependent on a working serial port and not dependent a physic=
al button.</div><div style=3D"font-family: &quot;SF Pro Text&quot;, system=
-ui, sans-serif;"><br></div><div style=3D"font-family: &quot;SF Pro Text&q=
uot;, system-ui, sans-serif;">About merging code to rockchip_dnl_mode_chec=
k() and same places:</div><div style=3D"font-family: &quot;SF Pro Text&quo=
t;, system-ui, sans-serif;">The SPL hotkey support is aim to provide a way=
 to enter MaskROM and more mode without ADC keys support. That's meaning w=
e didn't need a physical button in board to enter MaskROM.</div><div style=
=3D"font-family: &quot;SF Pro Text&quot;, system-ui, sans-serif;"><br></di=
v><div style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, sans-seri=
f;">About delay 100ms:</div><div style=3D"font-family: &quot;SF Pro Text&q=
uot;, system-ui, sans-serif;">I have tested this function on my Mekotronic=
s R58X-4G board, this is the shortest time that the hotkey can be detected=
. (Even though, I still need to press Ctrl+B before SPL running)</div><div=
 style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, sans-serif;"><d=
iv style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, sans-serif;">=
<br></div><div style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, s=
ans-serif;">Sorry for my poor English, I'm trying my best to describe the =
function of this config in Kconfig.</div><div style=3D"font-family: &quot;=
SF Pro Text&quot;, system-ui, sans-serif;"><br></div><div>The other sugges=
tions have been accepted in v4 patch. Like checking&nbsp;<span style=3D"co=
lor: rgba(255, 255, 255, 0.98); font-style: normal; font-variant-ligatures=
: normal; font-variant-caps: normal; font-weight: 300; letter-spacing: -0.=
37px; orphans: 2; text-align: start; text-indent: 0px; text-transform: non=
e; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-spa=
ce: normal; background-color: rgb(28, 28, 30); text-decoration-thickness: =
initial; text-decoration-style: initial; text-decoration-color: initial; f=
loat: none; display: inline !important;"><span class=3D"font" style=3D"fon=
t-family:&quot;SF Pro Text&quot;, system-ui, sans-serif"><span class=3D"si=
ze" style=3D"font-size:17px">CONFIG_ROCKCHIP_BOOT_MODE_REG, adding a small=
 comment. etc.</span></span></span></div></div><div style=3D"font-family: =
&quot;SF Pro Text&quot;, system-ui, sans-serif;"><br></div><div style=3D"f=
ont-family: &quot;SF Pro Text&quot;, system-ui, sans-serif;">Best regards,=
</div><div style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, sans-=
serif;">Valentin Liu</div><div style=3D"font-family: &quot;SF Pro Text&quo=
t;, system-ui, sans-serif;"><br></div><div><br></div><blockquote type=3D"c=
ite"><div>2026=E5=B9=B48=E6=9C=8820=E6=97=A5=E4=B8=8B=E5=8D=8811:38=EF=BC=8C=
Quentin Schulz &lt;u-boot@0leil.net&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><=
div><br></div><div><br></div><div><div><div>Hi Valentin,</div><div><br></d=
iv><div>On 8/18/26 6:55 PM, Valentin Liu wrote:</div><blockquote type=3D"c=
ite"><div>Add a configurable Rockchip SPL hotkey feature that checks the</=
div><div>serial console during SPL startup.</div><div><br></div><div>Ctrl+=
B can be used to enter BootROM download (MASKROM) mode and</div><div>be wi=
dely used. We can add more boot mode support in future.</div><div><br></di=
v><div>Add CONFIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for</=
div><div>the serial port to be ready to receive input before checking for<=
/div><div>hotkeys.</div><div><br></div><div>Signed-off-by: Valentin Liu &l=
t;valentinliu@icloud.com&gt;</div><div>---</div><div>Changes for v2:</div>=
<div>- Simplify the dependencies of SPL_ROCKCHIP_HOTKEY.</div><div>- Remov=
e the conditions for the newly added includes.</div><div>---</div><div>Cha=
nges for v3:</div><div>- Add a dummy spl_hotkey_init() to avoid undefined =
reference errors</div><div> when building without CONFIG_SPL_ROCKCHIP_HOTK=
EY.</div><div><br></div><div> arch/arm/mach-rockchip/Kconfig | 13 ++++++++=
++</div><div> arch/arm/mach-rockchip/spl.c   | 44 ++++++++++++++++++++++++=
++++++++++</div><div> 2 files changed, 57 insertions(+)</div><div><br></di=
v><div>diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchi=
p/Kconfig</div><div>index 1a2e7847c9e..f2d2b5520ef 100644</div><div>--- a/=
arch/arm/mach-rockchip/Kconfig</div><div>+++ b/arch/arm/mach-rockchip/Kcon=
fig</div><div>@@ -743,6 +743,19 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM=
</div><div> config SPL_MMC</div><div> default y if !SPL_ROCKCHIP_BACK_TO_B=
ROM</div><div> <br></div><div>+config SPL_ROCKCHIP_HOTKEY</div><div>+	bool=
 "SPL hotkey support"</div></blockquote><div><br></div><div>The symbol nam=
e and prompt is not clear enough on what it does.</div><div><br></div><div=
>config SPL_ROCKCHIP_ENTER_MASKROM_ON_KEY</div><div> bool "Enter MaskROM o=
n key press during SPL"</div><div><br></div><div>maybe?</div><div><br></di=
v><blockquote type=3D"cite"><div>+	depends on SPL_DM_RESET &amp;&amp; SPL_=
SERIAL</div><div>+	help</div><div>+	  Enable hotkey detection during SPL b=
ooting stage.</div><div>+</div><div>+	  When enabled, SPL checks the seria=
l console for a control</div><div>+	  character and can execute Rockchip-s=
pecific hotkey actions,</div><div>+	  such as entering BootROM download mo=
de (MASKROM) with Ctrl+B.</div><div>+</div><div>+	  The hotkey is checked =
after the SPL console has been</div><div>+	  initialized.</div><div>+</div=
></blockquote><div><br></div><div>Simplify to:</div><div><br></div><div>""=
"</div><div>When enabled, the SPL will check whether Ctrl+B is pressed and=
 enter </div><div>MaskROM in that case.</div><div>"""</div><div><br></div>=
<blockquote type=3D"cite"><div>config ROCKCHIP_SPI_IMAGE</div><div> bool "=
Build a SPI image for rockchip"</div><div> help</div><div>diff --git a/arc=
h/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c</div><div>index e=
989c148079..0bcfb42c306 100644</div><div>--- a/arch/arm/mach-rockchip/spl.=
c</div><div>+++ b/arch/arm/mach-rockchip/spl.c</div><div>@@ -13,11 +13,14 =
@@</div><div> #include &lt;log.h&gt;</div><div> #include &lt;mapmem.h&gt;<=
/div><div> #include &lt;ram.h&gt;</div><div>+#include &lt;serial.h&gt;</di=
v><div> #include &lt;spl.h&gt;</div><div>+#include &lt;asm/arch-rockchip/b=
oot_mode.h&gt;</div><div> #include &lt;asm/arch-rockchip/bootrom.h&gt;</di=
v><div> #include &lt;asm/arch-rockchip/timer.h&gt;</div><div> #include &lt=
;asm/global_data.h&gt;</div><div> #include &lt;asm/io.h&gt;</div><div>+#in=
clude &lt;linux/delay.h&gt;</div><div> #include &lt;linux/bitops.h&gt;</di=
v><div> <br></div><div> DECLARE_GLOBAL_DATA_PTR;</div><div>@@ -107,6 +110,=
44 @@ __weak int arch_cpu_init(void)</div><div> return 0;</div><div> }</di=
v><div> <br></div><div>+#if IS_ENABLED(CONFIG_SPL_ROCKCHIP_HOTKEY)</div></=
blockquote><div><br></div><div>Please use CONFIG_IS_ENABLED() instead.</di=
v><div><br></div><blockquote type=3D"cite"><div>+static void rockchip_rese=
t_from_hotkey(const int code)</div><div>+{</div><div>+	switch (code) {</di=
v><div>+	case 0x02:</div></blockquote><div><br></div><div>Please add a sma=
ll comment after 0x02: to specify which key combination </div><div>trigger=
s this code. E.g.:</div><div><br></div><div>case 0x02: /* Ctrl+B */</div><=
div><br></div><blockquote type=3D"cite">+		printf("SPL Hotkey: Ctrl+B: Boo=
tROM download!\n");</blockquote><div><br></div><div>Please be consistent w=
ith what we have in </div><div>arch/arm/mach-rockchip/boot_mode.c, that is=
:</div><div><br></div><div>"Ctrl+B pressed, entering download mode..."</di=
v><div><br></div><div>I don't like it, as it's typically called MaskROM, b=
ut it's something we </div><div>can fix later on and I prefer being consis=
tent with what we currently have.</div><div><br></div><blockquote type=3D"=
cite">+		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);</block=
quote><div><br></div><div>We *really* shouldn't be doing this if CONFIG_RO=
CKCHIP_BOOT_MODE_REG is </div><div>0 (the case for most boards).</div><div=
><br></div><blockquote type=3D"cite"><div>+		do_reset(NULL, 0, 0, NULL);</=
div><div>+		/*NOTREACHED*/</div><div>+	default:</div><div>+		if (code &lt;=
=3D 0x1a) /* 'z' */</div><div>+			printf("SPL Hotkey: Ctrl+%c\n", code + '=
A' - 1);</div><div>+		else</div><div>+			printf("SPL Hotkey: Unknown code:=
 0x%x, ignore\n", code);&gt; +	}&gt; +}</div><div>+</div><div>+static void=
 spl_hotkey_init(void)</div><div>+{</div><div>+	if (!gd || !(gd-&gt;flags =
&amp; GD_FLG_HAVE_CONSOLE))</div><div>+		return;</div><div>+	if (gd-&gt;fl=
ags &amp; GD_FLG_DISABLE_CONSOLE)</div><div>+		return;</div><div>+</div><d=
iv>+	/* Wait for the serial port to be ready to receive data. */</div><div=
>+	mdelay(100);</div><div>+</div></blockquote><div><br></div><div>Is it no=
t ready by the time we call this function? How did you come up </div><div>=
with 100ms?</div><div><br></div><blockquote type=3D"cite"><div>+	if (seria=
l_tstc())</div><div>+		rockchip_reset_from_hotkey(serial_getc());</div><di=
v>+	else</div><div>+		printf("SPL Hotkey: No key pressed, continue\n");</d=
iv></blockquote><div><br></div><div>We don't need to print on the standard=
 path. If you reaaaaaaally want to </div><div>have something, then use log=
_debug/debug instead so it isn't printed by </div><div>default except if y=
ou build with debug logging enabled.</div><div><br></div><blockquote type=3D=
"cite"><div>+}</div><div>+#else</div><div>+static void spl_hotkey_init(voi=
d)</div><div>+{</div><div>+}</div><div>+#endif</div><div>+</div><div> void=
 board_init_f(ulong dummy)</div><div> {</div><div> int ret;</div><div>@@ -=
143,6 +184,9 @@ void board_init_f(ulong dummy)</div><div> }</div><div> #en=
dif</div><div> preloader_console_init();</div><div>+</div><div>+	if (IS_EN=
ABLED(CONFIG_SPL_ROCKCHIP_HOTKEY))</div><div>+		spl_hotkey_init();</div></=
blockquote><div><br></div><div>Can we merge with the very similar logic we=
 have for an ADC button in </div><div>arch/arm/mach-rockchip/boot_mode.c i=
nstead? I believe it makes more </div><div>sense to have everything capabl=
e of entering MaskROM mode in the same </div><div>place, with the same log=
ic. I could see an else if() block in </div><div>rockchip_dnl_mode_check()=
 for example.</div><div><br></div><div>Cheers,</div><div>Quentin</div></di=
v></div></blockquote></div><div><br></div></body></html>
--Apple-Webmail-86--b3d78300-66bd-465e-904c-9714973bf5e4--

--Apple-Webmail-42--b3d78300-66bd-465e-904c-9714973bf5e4--

