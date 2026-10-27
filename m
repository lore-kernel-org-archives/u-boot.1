Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15144606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q+ZxFb9i;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=e9xfsAwX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7092405F3;
	Tue, 27 Oct 2026 08:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d-czXm7bLkQN; Tue, 27 Oct 2026 08:26:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A74D405F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793089570;
	b=LB8snwkWfh3NXlT5Xxk1XULia23VOXYl72OL4/M1nyqwBIuJMh7r5AZGk815Akp1beRa
	 Bma+97DOG69NXTFQLrf+mHKb+lLc3brD9YVhnqc9csXljIK4W2ccia4niTW9+dD0HfMAk
	 niyO41k1I/HaiguYkhFdBxjV0CxrmLA1r49X2n2XtsUvKQNDaG8yXjtCLCX2UIo/tXJPd
	 UajiUAuURRrMesEgHtfuX7m1osVE2YuID5gLgJAJRpDsJxnYgkp1L0CHY42Zpo/WPs+ZB
	 +n7zKHGvulBQ/VqcrMM4gSD6bFqd6xasNB3MmWbbCYMTys8jYrbKtHEn6hpM47u6wfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793089570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aYuHPUqWvjOuWo/FbinLag3iLX9eIkib/VV9QQXj2+I=;
	b=nBPoE1zriCMcqcWaiuGERZmJ0N4kdbeccO3szuiiu+0VkgAsmu8RyOikSCtyo5J52ACl
	 pl2cJmFTHgKGnDTeo0fE1CB2Cxh66WXEACcwV+jV2Nlciu+2cpnhiEaOziREEc8luQdO/
	 KrmUxX9hxwhvQlrkcgohDKxK9csOMM7cVp9weQahmJpcEMu/AkZE3MWsjYVhSyQJML6jP
	 kfaW5xDif5OpkvGwk5xhjRyuCvH2AVpjTY3RdJhkiLt37+dB8sfHILJlPi9rPTuWk3aJr
	 lP4AerThvC1De02nlicGB+ZFLyBfGJ+cr9jJbh0ZLEh0dlUAk4aSyBigu4uyYxAAHYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=e9xfsAwX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793089570;
	bh=aYuHPUqWvjOuWo/FbinLag3iLX9eIkib/VV9QQXj2+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q+ZxFb9iJ3Yf0RK07ObX+mM4DctnMLvMBwOoV+vPVgRF8WhsvhHvYuIFbkQOsQcmQ
	 NQivI9g4v8E2yEqfbeI1d3zvfC0iz7ddkOkHNIr4uAZJ+ShbcBYbNM7pRLlc5D62K8
	 JDv6qMKmP8M4NSbkcuMy5k71A7M5vNZTSV8HwzfzvxQ4lVQn4GY9CxkQyw9P50mqBx
	 vlD226C7gB+SFPOwEWnT2HwbkSBHQYqt55v4O/fxW7BAxeAZDffojqJ6GZS3OimaUT
	 Fy62ZRp+LaPi59Js9Vz95jCalBxA5vxualn68SqiSIantsbIcWNWneuvU83EhSxWFL
	 xN/TulFhZN9TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A74D405F8;
	Tue, 27 Oct 2026 08:26:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AB584BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C0D0405F8
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:26:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i4kpadUvZ_0h for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:26:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76D32405F3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793089566;
 b=WN4Zu806ukkUfBGYUifHyAq6hibcPhJZ+olPUuhQh1aID4a/1z3kUL9B9Va18QYSE3kK
 +iw2w8kXk1ca3853/syAMESOIZfUZJinB4v2GUsviN6SwGHU2WBQb0ggNHXZiQE01wHCh
 zHftajOWi0bv9rkldBmjYbhjDEoy283AUnDqgiq/Qta/XXNRWXdly45n105fkN7yDF7v0
 4uWNTUelFlkxLta6ds8P9W6Y3Clkj6LY4OoryFRbVDNgxyCedFrnlx3ai27T+GUWDgXGV
 UlD/6IVt251ff54OYdxSYop/9UARAsdpwO0LTikPqS569/QDZf4rDzqNbZvBclXrvJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793089566;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=aYuHPUqWvjOuWo/FbinLag3iLX9eIkib/VV9QQXj2+I=;
 b=YqeXBaSOf08DId39OvfcqJKh2UWUoKOFVNNhy/uX7fipsrUOcBXzfNwTZ8emDuoS3/ex
 FnDHUsAkj7h3ODAreHS39NpkDu44h7zS/A5QfdAyk+N7X4Y0mKx2YbAwgVJckaYCJueye
 wJ0mxirIVtYp5ElOHetsok3qMgf0GkF3LXzivF2fip8ZAvGBkDrEcFqYV6TaZONMMcmo0
 NEMUeBR9yyOtklHLZ4orO5rGQV87K3r0nTsFE+SWtGydeXCaunBASEbyjKE3G3DbwKg63
 +UH4H1P9Nws44DvaTJgPtwDPrfM1HulwK+nGTWHGTYaFLRxEbkPIuTT8rihlLFwpXXg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=e9xfsAwX; 
 arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=e9xfsAwX
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76D32405F3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793089550; x=1793694350; i=xypron.glpk@gmx.de;
 bh=aYuHPUqWvjOuWo/FbinLag3iLX9eIkib/VV9QQXj2+I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=e9xfsAwXkakIZ1Z7p+Mt705uTZNJcUegq+78/D2CrcNYdIO719u0MZRItPfsvuKA
 D9o2vneuO02Wk/x2XvDw6xKzZUYL/pOGYHVQrUgxnJysIg4Y6nZF/eihySyOqNqvD
 pVtuT7w/TjcWLK1IpCdRlY2bj2nhajAkp1nOtv+eG8xrLohrmL7PoxfJq3CbElheX
 z6nFhEl9A2r5pXkru0Qsk5xVUY4WBSNTGjf1w9PlCKa7ubOnKHpuKpXGHoLlNNi+x
 x2TaPlxs6AaCqydM2apq38NFmqIbG/TAHPjix/U9ygeAPTVXo6NCt3DfoZ7hpoEgn
 3FvWfaAJKppurHNHPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1wiyJK14mB-00eS19; Tue, 27
 Oct 2026 09:25:50 +0100
Message-ID: <52aca67f-1c6f-4bf6-a4cc-35fb4ead96fb@gmx.de>
Date: Tue, 27 Oct 2026 09:25:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: Cole Munz <Munzzyy1@proton.me>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Rajendran <pranavkasthuri@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov
 <alchark@flipper.net>, Carlo Caione <ccaione@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Samuel Holland <samuel@sholland.org>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>, =?UTF-8?Q?Jo=C3=A3o_Loureiro?=
 <joaofl@gmail.com>, Siu Ming Tong <smtong@axiado.com>,
 u-boot@lists.u-boot-project.org
References: <20261027012709.GA2177077@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261027012709.GA2177077@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GmAhedirefTqfw9OiTr3Chzdi4Ec/JJ1aCDdzVxOo3AaYnOVbNW
 eKMzOJbdmtTTzk5FRvV3Z/0xylNSOxz5cNPGSr2rWu/EMLnNCAIA/8D1VjxoMvRsW4F+3XG
 aOzsNoHg+xz0/IW3D0mdgCTx9CaDz/3sjeAR792PuFF/GBc0xdwJdg71eJG8DZbIZt5KKXo
 Y3gWN6x3HatUHAQu3Qn6Q==
UI-OutboundReport: notjunk:1;M01:P0:5n3BRf2BG2U=;BWJ+EsAyBHJjyjf1RDlOQP3h6V9
 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
 HA==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 02:27, Tom Rini wrote:
> Here's the latest report. Since it says 20 out of 25, I downloaded a
> report as well and the 5 not listed here are:
>=20
> CID 470520, Uninitialized scalar variable, lib/zstd/decompress/zstd_deco=
mpress.c, ZSTD_errorFrameSizeInfo
> CID 470520: (#1 of 1): Uninitialized scalar variable (UNINIT)
> 2. uninit_use: Using uninitialized value frameSizeInfo. Field frameSizeI=
nfo.nbBlocks is uninitialized.
> 700    return frameSizeInfo;
>=20
> CID 661171, Untrusted pointer read, cmd/gpio.c, do_gpio
> CID 661171: (#1 of 1): Untrusted pointer read (TAINTED_SCALAR)
> 16. tainted_data: Using tainted variable offset as an index to pointer u=
c_priv->name.
>        Ensure that tainted values are properly sanitized, by checking th=
at their values are within a permissible range.
> 238                printf("gpio: pin %s (gpio %u) already claimed by '%s=
'\n",
> 239                       str_gpio, gpio, uc_priv->name[offset]);
>=20
> CID 661172, Overflowed constant, test/boot/fit_cipher.c, fit_cipher_test=
_oversized_unciphered_size
>          info.size_unciphered =3D sizeof(cipher) + 1;
>        2. function_return: Function image_aes_decrypt(&info, cipher, 32U=
L, &data, &size) returns -22.
>        3. known_value_assign: ret =3D image_aes_decrypt(&info, cipher, 3=
2UL, &data, &size), its value is now -22.
>   65        ret =3D image_aes_decrypt(&info, cipher, sizeof(cipher), &da=
ta, &size);
>      =20
> CID 661172: (#1 of 1): Overflowed constant (INTEGER_OVERFLOW)
> 4. overflow_const: Expression _val2, where ret is known to be equal to -=
22, overflows the type of _val2, which is type unsigned int.
>   66        ut_asserteq(-EINVAL, ret);
>=20
> CID 661173, String not null terminated, boot/bootmeth_bls.c,bls_boot
>   =20
> CID 661173: (#1 of 1): String not null terminated (STRING_NULL)
> 7. string_null: Passing unterminated string label->name to parse_label_k=
eys, which expects a null-terminated string.[show details]
> 309        ret =3D parse_label_keys(&body, &scratch, label, true);
> 310        if (ret < 0)
>=20
> CID 661174, Unchecked return value from library, drivers/fastboot/fb_usb=
.c, fastboot_usb_run
> CID 661174: (#1 of 1): Unchecked return value from library (CHECKED_RETU=
RN)
> 7. check_return: Calling getchar() without checking return value. This l=
ibrary function may fail and return an error code. [Note: The source code =
implementation of the function has been overridden by a builtin model.]
> 48                                getchar();
>=20
> And I can provide more details on those specific issues if someone is
> looking at them and doesn't otherwise spot a problem.
>=20
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Oct 26, 2026 at 6:53=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>=20
>=20
> Hi,
>=20
> Please find the latest report on new defect(s) introduced to *Das U-Boot=
*
> found with Coverity Scan.
>=20
>     - *New Defects Found:* 25
>     - 13 defect(s), reported by Coverity Scan earlier, were marked fixed=
 in
>     the recent build analyzed by Coverity Scan.
>     - *Defects Shown:* Showing 20 of 25 defect(s)
>=20
> Defect Details
>=20
> ** CID 661194:         (CHECKED_RETURN)
> /drivers/video/panel-startek-kd070fhfid015.c: 173           in
> stk015_panel_enable_backlight()
> /drivers/video/panel-startek-kd070fhfid015.c: 171           in
> stk015_panel_enable_backlight()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661194:           (CHECKED_RETURN)
> /drivers/video/panel-startek-kd070fhfid015.c: 173             in
> stk015_panel_enable_backlight()
> 167
> 168     	return 0;
> 169
> 170     poweroff:
> 171     	regulator_disable(stk->power);
> 172     iovccoff:
>>>>      CID 661194:           (CHECKED_RETURN)
>>>>      Calling "regulator_set_enable_if_allowed" without checking retur=
n value (as is done elsewhere 59 out of 71 times).
> 173     	regulator_disable(stk->iovcc);
> 174     	dm_gpio_set_value(stk->reset_gpio, 0);
> 175     	dm_gpio_set_value(stk->enable_gpio, 0);
> 176     detach:
> 177     	mipi_dsi_detach(dsi);
> 178
> /drivers/video/panel-startek-kd070fhfid015.c: 171             in
> stk015_panel_enable_backlight()
> 165     		goto poweroff;
> 166     	}
> 167
> 168     	return 0;
> 169
> 170     poweroff:
>>>>      CID 661194:           (CHECKED_RETURN)
>>>>      Calling "regulator_set_enable_if_allowed" without checking retur=
n value (as is done elsewhere 59 out of 71 times).
> 171     	regulator_disable(stk->power);
> 172     iovccoff:
> 173     	regulator_disable(stk->iovcc);
> 174     	dm_gpio_set_value(stk->reset_gpio, 0);
> 175     	dm_gpio_set_value(stk->enable_gpio, 0);
> 176     detach:
>=20
> ** CID 661193:       Control flow issues  (DEADCODE)
> /boot/bootm.c: 741           in bootm_lz4_uncompressed_size()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661193:         Control flow issues  (DEADCODE)
> /boot/bootm.c: 741             in bootm_lz4_uncompressed_size()
> 735     	if (version !=3D 1 || !indep_blocks || (flg & 3) || (bd & 0x8f)=
 ||
> 736     	    !has_content_size)
> 737     		return 0;
> 738     	if (len < 4 + 2 + 8)
> 739     		return 0;
> 740     	cs =3D get_unaligned_le64(b + 6);
>>>>      CID 661193:         Control flow issues  (DEADCODE)

I marked this a intentional in Coverity as on 32bit this is not dead code.

>>>>      Execution cannot reach the expression "0UL" inside this statemen=
t: "return (cs > 18446744073709...".
> 741     	return cs > ULONG_MAX ? 0 : (ulong)cs;
> 742     }
> 743     #endif
> 744
> 745     #if CONFIG_IS_ENABLED(ZSTD)
> 746     /*
>=20
> ** CID 661192:       Control flow issues  (DEADCODE)
> /scripts/dtc/pylibfdt/libfdt_wrap.c: 4889           in _wrap_fdt_get_pat=
h()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661192:         Control flow issues  (DEADCODE)
> /scripts/dtc/pylibfdt/libfdt_wrap.c: 4889             in _wrap_fdt_get_p=
ath()
> 4883       result =3D (int)fdt_get_path((void const *)arg1,arg2,arg3,arg=
4);
> 4884       resultobj =3D SWIG_From_int((int)(result));
> 4885       resultobj =3D SWIG_Python_AppendOutput(resultobj,
> SWIG_FromCharPtr(arg3));
> 4886       if (buff3) free((char*)buff3);
> 4887       return resultobj;
> 4888     fail:
>>>>      CID 661192:         Control flow issues  (DEADCODE)
>>>>      Execution cannot reach this statement: "free((char *)buff3);".
> 4889       if (buff3) free((char*)buff3);

The Swig generated code contains SWIG_fail which jumps to fail.
So marked this a false positive.

> 4890       return NULL;
> 4891     }
> 4892
> 4893
> 4894     SWIGINTERN PyObject *_wrap_fdt_magic(PyObject *self, PyObject *=
args) {
>=20
> ** CID 661191:       Integer handling issues  (CONSTANT_EXPRESSION_RESUL=
T)
> /boot/bootm.c: 709           in bootm_lzma_uncompressed_size()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661191:         Integer handling issues  (CONSTANT_EXPRESSION_RE=
SULT)
> /boot/bootm.c: 709             in bootm_lzma_uncompressed_size()
> 703     	const u8 *b =3D src;
> 704     	u64 usize;
> 705
> 706     	if (len < LZMA_PROPS_SIZE + 8)
> 707     		return 0;
> 708     	usize =3D get_unaligned_le64(b + LZMA_PROPS_SIZE);
>>>>      CID 661191:         Integer handling issues  (CONSTANT_EXPRESSIO=
N_RESULT)
>>>>      "usize > 18446744073709551615ULL /* 9223372036854775807L * 2UL +=
 1UL */" is always false regardless of the values of its operands. This oc=
curs as the logical second operand of "||".

On 32bit systems this does not hold true. So I marked it as intentional=20
in Coverity.


> 709     	if (usize =3D=3D U64_MAX || usize > ULONG_MAX)
> 710     		return 0;
> 711     	return (ulong)usize;
> 712     }
> 713     #endif
> 714
>=20
> ** CID 661190:       Incorrect expression  (COPY_PASTE_ERROR)
> /lib/efi_selftest/efi_selftest_fmp.c: 139           in test_fmp()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661190:         Incorrect expression  (COPY_PASTE_ERROR)
> /lib/efi_selftest/efi_selftest_fmp.c: 139             in test_fmp()
> 133
> 134     		/*
> 135     		 * When support for authentication is compiled in, our updatab=
le
> 136     		 * images must require it, both as supported and set.
> 137     		 */
> 138     		if (IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE) &&
>>>>      CID 661190:         Incorrect expression  (COPY_PASTE_ERROR)
>>>>      "attr_set" in "attr_set & 1ULL" looks like a copy-paste error.

The code comment marks this as intended. I marked it as false positive=20
in Coverity.


> 139     		    (attr_set & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
> 140     		    !(attr_supp & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
> 141     			efi_st_error("Bad AttributesSupported %u\n",
> 142     				     (unsigned int)attr_supp);
> 143     			goto out;
> 144     		}
>=20
> ** CID 661189:         (CHECKED_RETURN)
> /drivers/video/panel-startek-kd070fhfid078.c: 277           in
> stk078_panel_enable_backlight()
> /drivers/video/panel-startek-kd070fhfid078.c: 282           in
> stk078_panel_enable_backlight()
> /drivers/video/panel-startek-kd070fhfid078.c: 279           in
> stk078_panel_enable_backlight()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661189:           (CHECKED_RETURN)
> /drivers/video/panel-startek-kd070fhfid078.c: 277             in
> stk078_panel_enable_backlight()
> 271
> 272     out_vdd:
> 273     	dm_gpio_set_value(stk->reset_gpio, 0);
> 274     	udelay(100);
> 275     	if (stk->enable_gpio)
> 276     		dm_gpio_set_value(stk->enable_gpio, 0);
>>>>      CID 661189:           (CHECKED_RETURN)
>>>>      Calling "regulator_set_enable_if_allowed" without checking retur=
n value (as is done elsewhere 59 out of 71 times).
> 277     	regulator_disable(stk->vdd);
> 278     out_iovcc:
> 279     	regulator_disable(stk->iovcc);
> 280     out_vddp:
> 281     	if (stk->vddp)
> 282     		regulator_disable(stk->vddp);
> /drivers/video/panel-startek-kd070fhfid078.c: 282             in
> stk078_panel_enable_backlight()
> 276     		dm_gpio_set_value(stk->enable_gpio, 0);
> 277     	regulator_disable(stk->vdd);
> 278     out_iovcc:
> 279     	regulator_disable(stk->iovcc);
> 280     out_vddp:
> 281     	if (stk->vddp)
>>>>      CID 661189:           (CHECKED_RETURN)
>>>>      Calling "regulator_set_enable_if_allowed" without checking retur=
n value (as is done elsewhere 59 out of 71 times).
> 282     		regulator_disable(stk->vddp);
> 283     out_detach:
> 284     	mipi_dsi_detach(dsi);
> 285
> 286     	return ret;
> 287     }
> /drivers/video/panel-startek-kd070fhfid078.c: 279             in
> stk078_panel_enable_backlight()
> 273     	dm_gpio_set_value(stk->reset_gpio, 0);
> 274     	udelay(100);
> 275     	if (stk->enable_gpio)
> 276     		dm_gpio_set_value(stk->enable_gpio, 0);
> 277     	regulator_disable(stk->vdd);
> 278     out_iovcc:
>>>>      CID 661189:           (CHECKED_RETURN)
>>>>      Calling "regulator_set_enable_if_allowed" without checking retur=
n value (as is done elsewhere 59 out of 71 times).
> 279     	regulator_disable(stk->iovcc);
> 280     out_vddp:
> 281     	if (stk->vddp)
> 282     		regulator_disable(stk->vddp);
> 283     out_detach:
> 284     	mipi_dsi_detach(dsi);
>=20
> ** CID 661188:       Integer handling issues  (CONSTANT_EXPRESSION_RESUL=
T)
> /boot/bootm.c: 741           in bootm_lz4_uncompressed_size()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661188:         Integer handling issues  (CONSTANT_EXPRESSION_RE=
SULT)
> /boot/bootm.c: 741             in bootm_lz4_uncompressed_size()
> 735     	if (version !=3D 1 || !indep_blocks || (flg & 3) || (bd & 0x8f)=
 ||
> 736     	    !has_content_size)
> 737     		return 0;
> 738     	if (len < 4 + 2 + 8)
> 739     		return 0;
> 740     	cs =3D get_unaligned_le64(b + 6);
>>>>      CID 661188:         Integer handling issues  (CONSTANT_EXPRESSIO=
N_RESULT)
>>>>      "cs > 18446744073709551615ULL /* 9223372036854775807L * 2UL + 1U=
L */" is always false regardless of the values of its operands. This occur=
s as the logical first operand of "?:".

On 32bit systems this constraint does not always evaluate to false. I=20
marked this as intentional in Coverity.


> 741     	return cs > ULONG_MAX ? 0 : (ulong)cs;
> 742     }
> 743     #endif
> 744
> 745     #if CONFIG_IS_ENABLED(ZSTD)
> 746     /*
>=20
> ** CID 661187:         (TAINTED_SCALAR)
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661187:           (TAINTED_SCALAR)
> /drivers/fastboot/fb_command.c: 952             in flashing_unlock_allow=
ed()
> 946     		sha256_update(&ctx, buf, cnt * info.blksz);
> 947     		last =3D buf[cnt * info.blksz - 1];
> 948     	}
> 949     	sha256_finish(&ctx, digest);
> 950     	allowed =3D !memcmp(stored, digest, SHA256_SUM_LEN) && last;
> 951     out:
>>>>      CID 661187:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "*buf" to "dlfree", which uses it as =
an offset.
> 952     	free(buf);
> 953
> 954     	return allowed;
> 955     }
> 956
> 957     /**
> /drivers/fastboot/fb_command.c: 940             in flashing_unlock_allow=
ed()
> 934
> 935     	sha256_starts(&ctx);
> 936     	for (blk =3D 0; blk < info.size; blk +=3D cnt) {
> 937     		cnt =3D info.size - blk;
> 938     		if (cnt > FLASHING_FRP_CHUNK)
> 939     			cnt =3D FLASHING_FRP_CHUNK;
>>>>      CID 661187:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "*buf" to "blk_dread", which uses it =
as an offset.
> 940     		if (blk_dread(desc, info.start + blk, cnt, buf) !=3D cnt)
> 941     			goto out;
> 942     		if (!blk) {
> 943     			memcpy(stored, buf, SHA256_SUM_LEN);
> 944     			memset(buf, 0, SHA256_SUM_LEN);
> 945     		}
> /drivers/fastboot/fb_command.c: 952             in flashing_unlock_allow=
ed()
> 946     		sha256_update(&ctx, buf, cnt * info.blksz);
> 947     		last =3D buf[cnt * info.blksz - 1];
> 948     	}
> 949     	sha256_finish(&ctx, digest);
> 950     	allowed =3D !memcmp(stored, digest, SHA256_SUM_LEN) && last;
> 951     out:
>>>>      CID 661187:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "*buf" to "dlfree", which uses it as =
an offset.
> 952     	free(buf);
> 953
> 954     	return allowed;
> 955     }
> 956
> 957     /**
> /drivers/fastboot/fb_command.c: 940             in flashing_unlock_allow=
ed()
> 934
> 935     	sha256_starts(&ctx);
> 936     	for (blk =3D 0; blk < info.size; blk +=3D cnt) {
> 937     		cnt =3D info.size - blk;
> 938     		if (cnt > FLASHING_FRP_CHUNK)
> 939     			cnt =3D FLASHING_FRP_CHUNK;
>>>>      CID 661187:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "*buf" to "blk_dread", which uses it =
as an offset.
> 940     		if (blk_dread(desc, info.start + blk, cnt, buf) !=3D cnt)
> 941     			goto out;
> 942     		if (!blk) {
> 943     			memcpy(stored, buf, SHA256_SUM_LEN);
> 944     			memset(buf, 0, SHA256_SUM_LEN);
> 945     		}
>=20
> ** CID 661186:       Insecure data handling  (INTEGER_OVERFLOW)
> /boot/imagemap.c: 409           in imagemap_blk_reader()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661186:         Insecure data handling  (INTEGER_OVERFLOW)
> /boot/imagemap.c: 409             in imagemap_blk_reader()
> 403     	 */
> 404     	if (desc->hwpart !=3D bp->hwpart) {
> 405     		blk_dselect_hwpart(desc, bp->hwpart);
> 406     		desc->hwpart =3D bp->hwpart;
> 407     	}
> 408
>>>>      CID 661186:         Insecure data handling  (INTEGER_OVERFLOW)
>>>>      "blk_dread(desc, bp->part_start + blk_off, count, buf) << desc->=
log2blksz", which might have overflowed, is returned from the function.
> 409     	return blk_dread(desc, bp->part_start + blk_off, count, buf)
> 410     	       << desc->log2blksz;
> 411     }
> 412
> 413     static int imagemap_probe(struct udevice *dev)
> 414     {
>=20
> ** CID 661185:         (DEADCODE)
> /lib/zstd/decompress/zstd_decompress_block.c: 2123           in
> ZSTD_decompressBlock_internal()
> /lib/zstd/decompress/zstd_decompress_block.c: 2133           in
> ZSTD_decompressBlock_internal()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661185:           (DEADCODE)
> /lib/zstd/decompress/zstd_decompress_block.c: 2123             in
> ZSTD_decompressBlock_internal()
> 2117                     "invalid dst");
> 2118
> 2119             /* If we could potentially have long offsets, or we
> might want to use the prefetch decoder,
> 2120              * compute information about the share of long
> offsets, and the maximum nbAdditionalBits.
> 2121              * NOTE: could probably use a larger nbSeq limit
> 2122              */
>>>>      CID 661185:           (DEADCODE)
>>>>      Execution cannot reach the expression "totalHistorySize > 167772=
16UL" inside this statement: "if (isLongOffset || (!usePr...".
> 2123             if (isLongOffset || (!usePrefetchDecoder &&
> (totalHistorySize > (1u << 24)) && (nbSeq > 8))) {
> 2124                 ZSTD_OffsetInfo const info =3D
> ZSTD_getOffsetInfo(dctx->OFTptr, nbSeq);
> 2125                 if (isLongOffset && info.maxNbAdditionalBits <=3D
> STREAM_ACCUMULATOR_MIN) {
> 2126                     /* If isLongOffset, but the maximum number of
> additional bits that we see in our table is small
> 2127                      * enough, then we know it is impossible to
> have too long an offset in this block, so we can
> 2128                      * use the regular offset decoder.
> /lib/zstd/decompress/zstd_decompress_block.c: 2133             in
> ZSTD_decompressBlock_internal()
> 2127                      * enough, then we know it is impossible to
> have too long an offset in this block, so we can
> 2128                      * use the regular offset decoder.
> 2129                      */
> 2130                     isLongOffset =3D ZSTD_lo_isRegularOffset;
> 2131                 }
> 2132                 if (!usePrefetchDecoder) {
>>>>      CID 661185:           (DEADCODE)
>>>>      Execution cannot reach the expression "minShare" inside this sta=
tement: "minShare =3D (MEM_64bits() ? ...".
> 2133                     U32 const minShare =3D MEM_64bits() ? 7 : 20;
> /* heuristic values, correspond to 2.73% and 7.81% */
> 2134                     usePrefetchDecoder =3D (info.longOffsetShare >=
=3D
> minShare);
> 2135                 }
> 2136             }
> 2137
> 2138             dctx->ddictIsCold =3D 0;
>=20
> ** CID 661184:       Error handling issues  (CHECKED_RETURN)
> /lib/zstd/common/fse.h: 509           in FSE_initDState()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661184:         Error handling issues  (CHECKED_RETURN)
> /lib/zstd/common/fse.h: 509             in FSE_initDState()
> 503
> 504     MEM_STATIC void FSE_initDState(FSE_DState_t* DStatePtr,
> BIT_DStream_t* bitD, const FSE_DTable* dt)
> 505     {
> 506         const void* ptr =3D dt;
> 507         const FSE_DTableHeader* const DTableH =3D (const
> FSE_DTableHeader*)ptr;
> 508         DStatePtr->state =3D BIT_readBits(bitD, DTableH->tableLog);
>>>>      CID 661184:         Error handling issues  (CHECKED_RETURN)
>>>>      Calling "BIT_reloadDStream" without checking return value (as is=
 done elsewhere 4 out of 5 times).
> 509         BIT_reloadDStream(bitD);
> 510         DStatePtr->table =3D dt + 1;
> 511     }
> 512
> 513     MEM_STATIC BYTE FSE_peekSymbol(const FSE_DState_t* DStatePtr)
> 514     {
>=20
> ** CID 661183:       Error handling issues  (CHECKED_RETURN)
> /drivers/serial/ns16550.c: 525           in ns16550_serial_probe()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661183:         Error handling issues  (CHECKED_RETURN)
> /drivers/serial/ns16550.c: 525             in ns16550_serial_probe()
> 519     	if (IS_ENABLED(CONFIG_NS16550_CLK_ENABLE) &&
> 520     	    CONFIG_IS_ENABLED(CLK)) {
> 521     		struct clk_bulk clk_bulk;
> 522
> 523     		ret =3D clk_get_bulk(dev, &clk_bulk);
> 524     		if (!ret)
>>>>      CID 661183:         Error handling issues  (CHECKED_RETURN)
>>>>      Calling "clk_enable_bulk" without checking return value (as is d=
one elsewhere 16 out of 20 times).
> 525     			clk_enable_bulk(&clk_bulk);
> 526     	}
> 527
> 528     	com_port->plat =3D dev_get_plat(dev);
> 529     	ns16550_init(com_port, -1);
> 530
>=20
> ** CID 661182:       Control flow issues  (DEADCODE)
> /lib/qrcodegen_gzip.c: 28           in qrcodegen_encodeBinaryCompressed(=
)
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661182:         Control flow issues  (DEADCODE)
> /lib/qrcodegen_gzip.c: 28             in qrcodegen_encodeBinaryCompresse=
d()
> 22     	if (qrcodegen_encodeBinary(dataAndTemp, dataLen, qrcode, ecl,
> 23     				   qrcodegen_VERSION_MIN, qrcodegen_VERSION_MAX,
> 24     				   qrcodegen_Mask_AUTO, true))
> 25     		return true;
> 26
> 27     	if (buf_max < QRGZ_MAGIC_LEN)
>>>>      CID 661182:         Control flow issues  (DEADCODE)
>>>>      Execution cannot reach this statement: "return false;".
> 28     		return false;
> 29
> 30     	scratch =3D qrcode;
> 31     	out_len =3D buf_max;
> 32     	if (gzip(scratch, &out_len, dataAndTemp, dataLen) !=3D 0)
> 33     		return false;
>=20
> ** CID 661181:       Insecure data handling  (TAINTED_SCALAR)
> /tools/fit_image.c: 1295           in fit_props_equal()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661181:         Insecure data handling  (TAINTED_SCALAR)
> /tools/fit_image.c: 1295             in fit_props_equal()
> 1289     	const void *a, *b;
> 1290     	int len_a, len_b;
> 1291
> 1292     	a =3D fdt_getprop(fdt, node_a, prop, &len_a);
> 1293     	b =3D fdt_getprop(fdt, node_b, prop, &len_b);
> 1294
>>>>      CID 661181:         Insecure data handling  (TAINTED_SCALAR)
>>>>      Passing tainted expression "len_a" to "memcmp", which uses it as=
 an offset. [Note: The source code implementation of the function has been=
 overridden by a builtin model.]
> 1295     	return a && b && len_a =3D=3D len_b && !memcmp(a, b, len_a);
> 1296     }
> 1297
> 1298     /**
> 1299      * fit_check_shared_cipher() - Check cipher settings of
> images sharing data
> 1300      *
>=20
> ** CID 661180:       Integer handling issues  (CONSTANT_EXPRESSION_RESUL=
T)
> /boot/bootm.c: 764           in bootm_zstd_uncompressed_size()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661180:         Integer handling issues  (CONSTANT_EXPRESSION_RE=
SULT)
> /boot/bootm.c: 764             in bootm_zstd_uncompressed_size()
> 758
> 759     	ret =3D zstd_get_frame_header(&hdr, src, len);
> 760     	if (zstd_is_error(ret) || ret > 0)
> 761     		return 0;
> 762     	if (hdr.frameContentSize =3D=3D ZSTD_CONTENTSIZE_UNKNOWN ||
> 763     	    hdr.frameContentSize =3D=3D ZSTD_CONTENTSIZE_ERROR ||
>>>>      CID 661180:         Integer handling issues  (CONSTANT_EXPRESSIO=
N_RESULT)
>>>>      "hdr.frameContentSize > 18446744073709551615ULL /* 9223372036854=
775807L * 2UL + 1UL */" is always false regardless of the values of its op=
erands. This occurs as the logical second operand of "||".

I marked this a intentional in Coverity as on 32 bit this is not=20
necessarily false.

Best regards

Heinrich

> 764     	    hdr.frameContentSize > ULONG_MAX)
> 765     		return 0;
> 766     	return (ulong)hdr.frameContentSize;
> 767     }
> 768     #endif
> 769
>=20
> ** CID 661179:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/lib/part_efi.c: 261           in lib_test_gpt_blkmap()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661179:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/lib/part_efi.c: 261             in lib_test_gpt_blkmap()
> 255     		gpt_head =3D malloc_cache_aligned(roundup(sizeof(gpt_header),
> 256     							blksz));
> 257     		ret =3D gpt_head ? blkmap_create(GPT_TEST_LABEL, &dev) : -ENOM=
EM;
> 258     		if (ret) {
> 259     			free(gpt_head);
> 260     			free(buf);
>>>>      CID 661179:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -12, ove=
rflows the type of "_val2", which is type "unsigned int".
> 261     			ut_assertok(ret);
> 262     		}
> 263
> 264     		/*
> 265     		 * A failed check returns early, so clean up here rather than
> 266     		 * in the helper. The device lives under the real dm_root, and
>=20
> ** CID 661178:       Control flow issues  (NO_EFFECT)
> /drivers/mmc/spacemit_sdhci.c: 476           in spacemit_sdhci_execute_t=
uning()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661178:         Control flow issues  (NO_EFFECT)
> /drivers/mmc/spacemit_sdhci.c: 476             in
> spacemit_sdhci_execute_tuning()
> 470     		int retry_count =3D ARRAY_SIZE(retry_delays);
> 471
> 472     		log_warning("Primary delay %d failed, trying alternatives\n",
> 473     			    final_delay);
> 474
> 475     		for (i =3D 0; i < retry_count; i++) {
>>>>      CID 661178:         Control flow issues  (NO_EFFECT)
>>>>      This greater-than-or-equal-to-zero comparison of an unsigned val=
ue is always true. "retry_delays[i] >=3D 0".
> 476     			if (retry_delays[i] >=3D SPACEMIT_RX_TUNE_DELAY_MIN &&
> 477     			    retry_delays[i] <=3D SPACEMIT_RX_TUNE_DELAY_MAX) {
> 478     				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
> 479     				ret =3D mmc_send_tuning(host->mmc, opcode);
> 480     				if (!ret) {
> 481     					final_delay =3D retry_delays[i];
>=20
> ** CID 661177:       Insecure data handling  (TAINTED_SCALAR)
> /drivers/misc/spi_eeprom_emul.c: 98           in sandbox_spi_eeprom_prob=
e()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661177:         Insecure data handling  (TAINTED_SCALAR)
> /drivers/misc/spi_eeprom_emul.c: 98             in sandbox_spi_eeprom_pr=
obe()
> 92     					  SANDBOX_SPI_EEPROM_SIZE);
> 93     	priv->data =3D calloc(1, priv->size);
> 94     	if (!priv->data)
> 95     		return -ENOMEM;
> 96
> 97     	/* Fill with a known pattern so reads can be verified */
>>>>      CID 661177:         Insecure data handling  (TAINTED_SCALAR)
>>>>      Using tainted variable "priv->size" as a loop boundary.
> 98     	for (i =3D 0; i < priv->size; i++)
> 99     		priv->data[i] =3D i & 0xff;
> 100
> 101     	return 0;
> 102     }
> 103
>=20
> ** CID 661176:       Error handling issues  (CHECKED_RETURN)
> /drivers/mmc/axiado_sdhci.c: 138           in axiado_sdhci_execute_tunin=
g()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661176:         Error handling issues  (CHECKED_RETURN)
> /drivers/mmc/axiado_sdhci.c: 138             in axiado_sdhci_execute_tun=
ing()
> 132     		sdhci_writew(host,
> 133     			     SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, data.blocks=
ize),
> 134     			     SDHCI_BLOCK_SIZE);
> 135     		sdhci_writew(host, data.blocks, SDHCI_BLOCK_COUNT);
> 136     		sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
> 137
>>>>      CID 661176:         Error handling issues  (CHECKED_RETURN)
>>>>      Calling "mmc_send_cmd" without checking return value (as is done=
 elsewhere 37 out of 46 times).
> 138     		mmc_send_cmd(mmc, &cmd, NULL);
> 139
> 140     		ctrl =3D sdhci_readw(host, SDHCI_HOST_CTRL2);
> 141
> 142     		if (cmd.cmdidx =3D=3D MMC_CMD_SEND_TUNING_BLOCK)
> 143     			udelay(1);
>=20
> ** CID 661175:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/boot/fit_cipher.c: 37           in fit_cipher_test_unaligned_len()
>=20
>=20
> ________________________________________________________________________=
_____________________
> *** CID 661175:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/boot/fit_cipher.c: 37             in fit_cipher_test_unaligned_len=
()
> 31     	info.cipher =3D image_get_cipher_algo("aes128");
> 32     	ut_assertnonnull(info.cipher);
> 33     	info.key =3D key;
> 34     	info.iv =3D iv;
> 35
> 36     	ret =3D image_aes_decrypt(&info, cipher, sizeof(cipher), &data, =
&size);
>>>>      CID 661175:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -22, ove=
rflows the type of "_val2", which is type "unsigned int".
> 37     	ut_asserteq(-EINVAL, ret);
> 38     	ut_assertnull(data);
> 39
> 40     	return 0;
> 41     }
> 42     FIT_CIPHER_TEST(fit_cipher_test_unaligned_len, 0);
>=20
>=20
>=20
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>
>=20
> Best regards,
>=20
> The Coverity Scan Admin Team
>=20
> ----- End forwarded message -----
>=20

