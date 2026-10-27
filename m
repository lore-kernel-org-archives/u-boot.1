Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F3606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D+pHYw1m;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ka+T59CQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED53A605EC;
	Tue, 27 Oct 2026 01:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7v82KzxdPYbx; Tue, 27 Oct 2026 01:27:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39EA1605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793064439;
	b=X318pKOFsqugS2gnkGgmVy1MYKe0hhPoxh3S3NLjMIwGpIA3JM2TGz/TOjwBeP/5iGgG
	 kMBR2pfWVKkKhoG8u1hUxRPDMpQVOW/yQwcz8xLTfgDb4pir42hC5eWBBY7DRBZ32aSiR
	 48F5bVDLpvwoBzPtkLKe9efe/fM0bgFhFfzOCcOAwtqRSAC//ULN1Nk1R5n/MqPO9B6b/
	 lYvBPwZ1PX+2qu4EFTI8S2bw63aV7ulUi+1fZ8qfUSAaqHwq0oVFoarZ2ROuuTODoTeRc
	 7Xx0RpmPCeMtliRy3bCzMY5myVx4OB22AhVPu5fOXQaQGOFWZk9IgMMCp/C6ODQDUsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793064439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g3Bx4TWixUTgYB8xgJGmYhyBpMVx+wBEGk7ST44TPZw=;
	b=JB1p6GFBQzunPGGeLx7EwC+YgptDThQNowux4VMEw8qH139srKvs+OVgMI3jhApLuB9T
	 GXhKZWWRJpU2YbMHLkuhuGBZIpPrf37ZZJIKzjYQ05VA+LFmeRteUenofVM5xbyOSC7DV
	 P1cFGDU4dNpXmVKZdlcsPmO3d2t/EpugVwHQpoaccDDsGQ2gylQy7vERzmH25daBEhYsp
	 xBsf0g8jbQgewQwGlY9AOuimDIN8N+J3/KkN22JAi5VvAV97Ti54+KzY955LEBH0/yu/d
	 QuvJyUrBNzsMqdbh8y3mr/8E+d1e8LtC4Xfhb4qWP4hlhyj/aSowvgUKUB2IKY6Wv7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ka+T59CQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793064439;
	bh=g3Bx4TWixUTgYB8xgJGmYhyBpMVx+wBEGk7ST44TPZw=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D+pHYw1miz+iXhAh0nZtblkGLrzZHXLfXRAVtLwmmFVBDL84jOYYNlVmTbZ9MDCbw
	 l9YIC+FLCq//pWB5KurZduQWPHJO4fgxkVX2yobaJptY0AG/xD+JF8Nw3YgCSONk0s
	 hOvbnePTQYchhkOa4emtnwDJK5jIOmMprPtI2c9+Y4boBuHgA8jbNv5Sg3di+clz2P
	 dYK0+Vi0CH02CfNDD4JSyDmbw4lUQpls1tAvstGI5b4EI9vqBQ42S7wMR8jfejaokT
	 hdV4Rch4ba8s64Qs3xiH122L8ZeVC81MWgChJi/FewmLLqvTP4SJGBsT3sIcGyCzia
	 N4M8DDAm4eXzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39EA1605F9;
	Tue, 27 Oct 2026 01:27:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 31AA1B91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 171CE605F9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7hjNLGxr6OL for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 01:27:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1C3ED605EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793064435;
 b=JdG9Rexi90cbuuanvOf6hgmx2rxoGiJ5Za/yn45xr9peXz4dK+WP2U0w3awyiXldfdZS
 Oo2BSDWqvozqIH04JxJUwJbUE3OOPCBGfgD+KobIdATGtc5fyjNWFS5mhciEi0Xqi/KoI
 Dyn0F+SyzppvWmS58GkeoMJsSyA2fWyRaRzI1ggokcHziZv2MskwoUjjzCiYDcazlsKhr
 ODjlgNZDEncz1RkTfgRcpVpRe92hPTLyeOAtVA/4gjsZZdThPnXbEd9wqCtlEFnQE22hV
 8EXxOFULnyBK0m+1HMtSteHZTNUrLHDrBmZ7Fo8tts6ilSf+dfI5+Co9LMziNiJqqzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793064435;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
 X-Clacks-Overhead;
 bh=g3Bx4TWixUTgYB8xgJGmYhyBpMVx+wBEGk7ST44TPZw=;
 b=sowuS518RIxaGRESOmNQJsgDwfnn6pyHg9HPG5oIXgUIfIcB//7u/pcpoHn8hsFaxZj6
 5POOggmfQqpcS0XYtnhrKA7kSC6JKJSddzJljRDI5NxRY6JmVekpr9uN11i5mCwSW+O9s
 NkYILbgy9DbAPSjABeDIaPIQ8s7RGjFLPnK4RBb8KRlkeHRQoWak1uU2HzXo5lHEwls+s
 NBir1vHjw0/3NCsqj0CqiDM/iOwE1cpJxKneRu0k45Q2ty+RvfVXK6hfe0zYq+vscfG3F
 9dGX0+FEonEhWnPw/yowy95N4aZkyWi4+xSPt7PdE+WWrwc5fDhF5aLRMIUcJ5nmNOA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ka+T59CQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::a;
 helo=mail-oa2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ka+T59CQ
Received: from mail-oa2-x0a.google.com (mail-oa2-x0a.google.com
 [IPv6:2607:f8b0:4864:30::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C3ED605EC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:27:14 +0000 (UTC)
Received: by mail-oa2-x0a.google.com with SMTP id
 586e51a60fabf-4a73bb0314aso1681549fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793064433; x=1793669233;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g3Bx4TWixUTgYB8xgJGmYhyBpMVx+wBEGk7ST44TPZw=;
 b=ka+T59CQAWfcE6+gHSvd4AqUbo8p+lUNQBsybI13mcNmi/IVpSAA2uoP7E6qTvdS7t
 v36EP5AGo51OwyfjN2Ixn8GWs9tIkna9L0tlcXQVGQXnQnAEUGuf0pUjiptcWvT18mgd
 LrnZWTfFXLwX6I1PQlqXHBAIKNmZdhxhwX6PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793064433; x=1793669233;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g3Bx4TWixUTgYB8xgJGmYhyBpMVx+wBEGk7ST44TPZw=;
 b=Y1dvmvAKzZqeboETmC8JO8/izvmBhSxSEkeq6nRFGhc7GbzHLNhjIlCbynm1je7Ier
 nxbhCX99WzBpX3oLqTKRfbu3DQxkenufVy8pzk5WJ76G6n7ENFWKj2uKrdRWm+T1tkjM
 +8DjeTm0h0+iGSNvNgiD/LmL8OE/RamXALrmI1Tcfp7CySOMUtvdS3IHbDFDyR/+zMto
 RCzRC4wvqVbZRHM/Yi+dbV4tnJLTFbZLmvadJmRVL4e9CpLMWky2aE57asqYOQe7RAzs
 mv91isYF7Fqy90OnLIhxDCpAkf3ThNjGp8j/tnFeCBwDtCAoqWcrNE90+4p86FLq9/Ve
 277w==
X-Gm-Message-State: AFq9FYK13AYGvvxWWJtKIXUP9o79/4dhzMMSpu+KMcEpHwSx4O+9vyBe
 1IBLln7/5impetfczi+gPGGDUsU1ty7wo+88MBVl9Ghx54ABs+AX3HT4beRk4PZCe6HK7Ro+eVh
 a110j/Bo6oYxIrCs=
X-Gm-Gg: AYBFou1c0qtx2F6MgYQPm825Svt7zvLsc8fskkS7itEk3+kVX9v2dV5a7ByzKGKc1pg
 xElhuvmWxwmvN9kC2K16PMgktd1/rpzp/a5iE4INP/ZMuF73rJ6x4oLdtA8cZXjr+YdyY4ySiln
 tXR/dnkxb+dreV7te7Y1cycm6mxj+4qsHiwnMVarYpps10Ez9JACkrnEzjX8mC7SnLbqLWqZAJX
 8daf1oO2vxyfspYXm/qyFUDl7TVXzoZn6Gjj7buk2hX0DekqNG6E6ImOh7balYk1KQG4iq/0Lsb
 WJTZA23jbi41KMsmqbyYWb3hdB//F+6juqFIqs6itxFPvBD+J5clcyNCotIM4XENsh2+vZU9Tuc
 exKX06kIoKsbEx+achMN0HPS5lkRk6BQtXJkYV+5XfWp5tOBCLzXCGpzoe3TOUcQWCix0P3Kpr1
 OrbZw1iijCisOcVz9PhodmM6Urgnvd+C7myluWzR0PEbjxSjKaOF/ZErEQOzTdwudKRUntl05Q0
 2BxB2dum53ji/wtoLd6uu/C7TSkQg1740ndfESf94Q7xatwThtRD+87dFwZX0wFBzMh+T6WtNDT
 4bln2Xal8pt7l8id7GMrEq62HpnkJlcIQwDSZPnj1d3mdrLEv0ELwwwGGyCipAHqf20u4pAzleM
 sTbjML0DERGD1fM6VMKYUibSoWGiSMldzKHueiPPb/6JLy/GZ8FKOZrVB9g==
X-Received: by 2002:a05:6808:2383:b0:53a:e153:e8e6 with SMTP id
 5614622812f47-55c002e2bc3mr5172915b6e.59.1793064433244; 
 Mon, 26 Oct 2026 18:27:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04311a8asm6638354b6e.16.2026.10.26.18.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 18:27:12 -0700 (PDT)
Date: Mon, 26 Oct 2026 19:27:09 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Cole Munz <Munzzyy1@proton.me>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Rajendran <pranavkasthuri@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Alexey Charkov <alchark@flipper.net>, Carlo Caione <ccaione@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Samuel Holland <samuel@sholland.org>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 Siu Ming Tong <smtong@axiado.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20261027012709.GA2177077@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="83f5AXGC8osCg18V"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--83f5AXGC8osCg18V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report. Since it says 20 out of 25, I downloaded a
report as well and the 5 not listed here are:

CID 470520, Uninitialized scalar variable, lib/zstd/decompress/zstd_decompr=
ess.c, ZSTD_errorFrameSizeInfo
CID 470520: (#1 of 1): Uninitialized scalar variable (UNINIT)
2. uninit_use: Using uninitialized value frameSizeInfo. Field frameSizeInfo=
=2EnbBlocks is uninitialized.
700    return frameSizeInfo;

CID 661171, Untrusted pointer read, cmd/gpio.c, do_gpio
CID 661171: (#1 of 1): Untrusted pointer read (TAINTED_SCALAR)
16. tainted_data: Using tainted variable offset as an index to pointer uc_p=
riv->name.
      Ensure that tainted values are properly sanitized, by checking that t=
heir values are within a permissible range.
238                printf("gpio: pin %s (gpio %u) already claimed by '%s'\n=
",
239                       str_gpio, gpio, uc_priv->name[offset]);

CID 661172, Overflowed constant, test/boot/fit_cipher.c, fit_cipher_test_ov=
ersized_unciphered_size
        info.size_unciphered =3D sizeof(cipher) + 1;
      2. function_return: Function image_aes_decrypt(&info, cipher, 32UL, &=
data, &size) returns -22.
      3. known_value_assign: ret =3D image_aes_decrypt(&info, cipher, 32UL,=
 &data, &size), its value is now -22.
 65        ret =3D image_aes_decrypt(&info, cipher, sizeof(cipher), &data, =
&size);
    =20
CID 661172: (#1 of 1): Overflowed constant (INTEGER_OVERFLOW)
4. overflow_const: Expression _val2, where ret is known to be equal to -22,=
 overflows the type of _val2, which is type unsigned int.
 66        ut_asserteq(-EINVAL, ret);

CID 661173, String not null terminated, boot/bootmeth_bls.c,bls_boot
 =20
CID 661173: (#1 of 1): String not null terminated (STRING_NULL)
7. string_null: Passing unterminated string label->name to parse_label_keys=
, which expects a null-terminated string.[show details]
309        ret =3D parse_label_keys(&body, &scratch, label, true);
310        if (ret < 0)

CID 661174, Unchecked return value from library, drivers/fastboot/fb_usb.c,=
 fastboot_usb_run
CID 661174: (#1 of 1): Unchecked return value from library (CHECKED_RETURN)
7. check_return: Calling getchar() without checking return value. This libr=
ary function may fail and return an error code. [Note: The source code impl=
ementation of the function has been overridden by a builtin model.]
48                                getchar();

And I can provide more details on those specific issues if someone is
looking at them and doesn't otherwise spot a problem.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Oct 26, 2026 at 6:53=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 25
   - 13 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 20 of 25 defect(s)

Defect Details

** CID 661194:         (CHECKED_RETURN)
/drivers/video/panel-startek-kd070fhfid015.c: 173           in
stk015_panel_enable_backlight()
/drivers/video/panel-startek-kd070fhfid015.c: 171           in
stk015_panel_enable_backlight()


___________________________________________________________________________=
__________________
*** CID 661194:           (CHECKED_RETURN)
/drivers/video/panel-startek-kd070fhfid015.c: 173             in
stk015_panel_enable_backlight()
167
168     	return 0;
169
170     poweroff:
171     	regulator_disable(stk->power);
172     iovccoff:
>>>     CID 661194:           (CHECKED_RETURN)
>>>     Calling "regulator_set_enable_if_allowed" without checking return v=
alue (as is done elsewhere 59 out of 71 times).
173     	regulator_disable(stk->iovcc);
174     	dm_gpio_set_value(stk->reset_gpio, 0);
175     	dm_gpio_set_value(stk->enable_gpio, 0);
176     detach:
177     	mipi_dsi_detach(dsi);
178
/drivers/video/panel-startek-kd070fhfid015.c: 171             in
stk015_panel_enable_backlight()
165     		goto poweroff;
166     	}
167
168     	return 0;
169
170     poweroff:
>>>     CID 661194:           (CHECKED_RETURN)
>>>     Calling "regulator_set_enable_if_allowed" without checking return v=
alue (as is done elsewhere 59 out of 71 times).
171     	regulator_disable(stk->power);
172     iovccoff:
173     	regulator_disable(stk->iovcc);
174     	dm_gpio_set_value(stk->reset_gpio, 0);
175     	dm_gpio_set_value(stk->enable_gpio, 0);
176     detach:

** CID 661193:       Control flow issues  (DEADCODE)
/boot/bootm.c: 741           in bootm_lz4_uncompressed_size()


___________________________________________________________________________=
__________________
*** CID 661193:         Control flow issues  (DEADCODE)
/boot/bootm.c: 741             in bootm_lz4_uncompressed_size()
735     	if (version !=3D 1 || !indep_blocks || (flg & 3) || (bd & 0x8f) ||
736     	    !has_content_size)
737     		return 0;
738     	if (len < 4 + 2 + 8)
739     		return 0;
740     	cs =3D get_unaligned_le64(b + 6);
>>>     CID 661193:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "0UL" inside this statement: =
"return (cs > 18446744073709...".
741     	return cs > ULONG_MAX ? 0 : (ulong)cs;
742     }
743     #endif
744
745     #if CONFIG_IS_ENABLED(ZSTD)
746     /*

** CID 661192:       Control flow issues  (DEADCODE)
/scripts/dtc/pylibfdt/libfdt_wrap.c: 4889           in _wrap_fdt_get_path()


___________________________________________________________________________=
__________________
*** CID 661192:         Control flow issues  (DEADCODE)
/scripts/dtc/pylibfdt/libfdt_wrap.c: 4889             in _wrap_fdt_get_path=
()
4883       result =3D (int)fdt_get_path((void const *)arg1,arg2,arg3,arg4);
4884       resultobj =3D SWIG_From_int((int)(result));
4885       resultobj =3D SWIG_Python_AppendOutput(resultobj,
SWIG_FromCharPtr(arg3));
4886       if (buff3) free((char*)buff3);
4887       return resultobj;
4888     fail:
>>>     CID 661192:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "free((char *)buff3);".
4889       if (buff3) free((char*)buff3);
4890       return NULL;
4891     }
4892
4893
4894     SWIGINTERN PyObject *_wrap_fdt_magic(PyObject *self, PyObject *arg=
s) {

** CID 661191:       Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/boot/bootm.c: 709           in bootm_lzma_uncompressed_size()


___________________________________________________________________________=
__________________
*** CID 661191:         Integer handling issues  (CONSTANT_EXPRESSION_RESUL=
T)
/boot/bootm.c: 709             in bootm_lzma_uncompressed_size()
703     	const u8 *b =3D src;
704     	u64 usize;
705
706     	if (len < LZMA_PROPS_SIZE + 8)
707     		return 0;
708     	usize =3D get_unaligned_le64(b + LZMA_PROPS_SIZE);
>>>     CID 661191:         Integer handling issues  (CONSTANT_EXPRESSION_R=
ESULT)
>>>     "usize > 18446744073709551615ULL /* 9223372036854775807L * 2UL + 1U=
L */" is always false regardless of the values of its operands. This occurs=
 as the logical second operand of "||".
709     	if (usize =3D=3D U64_MAX || usize > ULONG_MAX)
710     		return 0;
711     	return (ulong)usize;
712     }
713     #endif
714

** CID 661190:       Incorrect expression  (COPY_PASTE_ERROR)
/lib/efi_selftest/efi_selftest_fmp.c: 139           in test_fmp()


___________________________________________________________________________=
__________________
*** CID 661190:         Incorrect expression  (COPY_PASTE_ERROR)
/lib/efi_selftest/efi_selftest_fmp.c: 139             in test_fmp()
133
134     		/*
135     		 * When support for authentication is compiled in, our updatable
136     		 * images must require it, both as supported and set.
137     		 */
138     		if (IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE) &&
>>>     CID 661190:         Incorrect expression  (COPY_PASTE_ERROR)
>>>     "attr_set" in "attr_set & 1ULL" looks like a copy-paste error.
139     		    (attr_set & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
140     		    !(attr_supp & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
141     			efi_st_error("Bad AttributesSupported %u\n",
142     				     (unsigned int)attr_supp);
143     			goto out;
144     		}

** CID 661189:         (CHECKED_RETURN)
/drivers/video/panel-startek-kd070fhfid078.c: 277           in
stk078_panel_enable_backlight()
/drivers/video/panel-startek-kd070fhfid078.c: 282           in
stk078_panel_enable_backlight()
/drivers/video/panel-startek-kd070fhfid078.c: 279           in
stk078_panel_enable_backlight()


___________________________________________________________________________=
__________________
*** CID 661189:           (CHECKED_RETURN)
/drivers/video/panel-startek-kd070fhfid078.c: 277             in
stk078_panel_enable_backlight()
271
272     out_vdd:
273     	dm_gpio_set_value(stk->reset_gpio, 0);
274     	udelay(100);
275     	if (stk->enable_gpio)
276     		dm_gpio_set_value(stk->enable_gpio, 0);
>>>     CID 661189:           (CHECKED_RETURN)
>>>     Calling "regulator_set_enable_if_allowed" without checking return v=
alue (as is done elsewhere 59 out of 71 times).
277     	regulator_disable(stk->vdd);
278     out_iovcc:
279     	regulator_disable(stk->iovcc);
280     out_vddp:
281     	if (stk->vddp)
282     		regulator_disable(stk->vddp);
/drivers/video/panel-startek-kd070fhfid078.c: 282             in
stk078_panel_enable_backlight()
276     		dm_gpio_set_value(stk->enable_gpio, 0);
277     	regulator_disable(stk->vdd);
278     out_iovcc:
279     	regulator_disable(stk->iovcc);
280     out_vddp:
281     	if (stk->vddp)
>>>     CID 661189:           (CHECKED_RETURN)
>>>     Calling "regulator_set_enable_if_allowed" without checking return v=
alue (as is done elsewhere 59 out of 71 times).
282     		regulator_disable(stk->vddp);
283     out_detach:
284     	mipi_dsi_detach(dsi);
285
286     	return ret;
287     }
/drivers/video/panel-startek-kd070fhfid078.c: 279             in
stk078_panel_enable_backlight()
273     	dm_gpio_set_value(stk->reset_gpio, 0);
274     	udelay(100);
275     	if (stk->enable_gpio)
276     		dm_gpio_set_value(stk->enable_gpio, 0);
277     	regulator_disable(stk->vdd);
278     out_iovcc:
>>>     CID 661189:           (CHECKED_RETURN)
>>>     Calling "regulator_set_enable_if_allowed" without checking return v=
alue (as is done elsewhere 59 out of 71 times).
279     	regulator_disable(stk->iovcc);
280     out_vddp:
281     	if (stk->vddp)
282     		regulator_disable(stk->vddp);
283     out_detach:
284     	mipi_dsi_detach(dsi);

** CID 661188:       Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/boot/bootm.c: 741           in bootm_lz4_uncompressed_size()


___________________________________________________________________________=
__________________
*** CID 661188:         Integer handling issues  (CONSTANT_EXPRESSION_RESUL=
T)
/boot/bootm.c: 741             in bootm_lz4_uncompressed_size()
735     	if (version !=3D 1 || !indep_blocks || (flg & 3) || (bd & 0x8f) ||
736     	    !has_content_size)
737     		return 0;
738     	if (len < 4 + 2 + 8)
739     		return 0;
740     	cs =3D get_unaligned_le64(b + 6);
>>>     CID 661188:         Integer handling issues  (CONSTANT_EXPRESSION_R=
ESULT)
>>>     "cs > 18446744073709551615ULL /* 9223372036854775807L * 2UL + 1UL *=
/" is always false regardless of the values of its operands. This occurs as=
 the logical first operand of "?:".
741     	return cs > ULONG_MAX ? 0 : (ulong)cs;
742     }
743     #endif
744
745     #if CONFIG_IS_ENABLED(ZSTD)
746     /*

** CID 661187:         (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 661187:           (TAINTED_SCALAR)
/drivers/fastboot/fb_command.c: 952             in flashing_unlock_allowed()
946     		sha256_update(&ctx, buf, cnt * info.blksz);
947     		last =3D buf[cnt * info.blksz - 1];
948     	}
949     	sha256_finish(&ctx, digest);
950     	allowed =3D !memcmp(stored, digest, SHA256_SUM_LEN) && last;
951     out:
>>>     CID 661187:           (TAINTED_SCALAR)
>>>     Passing tainted expression "*buf" to "dlfree", which uses it as an =
offset.
952     	free(buf);
953
954     	return allowed;
955     }
956
957     /**
/drivers/fastboot/fb_command.c: 940             in flashing_unlock_allowed()
934
935     	sha256_starts(&ctx);
936     	for (blk =3D 0; blk < info.size; blk +=3D cnt) {
937     		cnt =3D info.size - blk;
938     		if (cnt > FLASHING_FRP_CHUNK)
939     			cnt =3D FLASHING_FRP_CHUNK;
>>>     CID 661187:           (TAINTED_SCALAR)
>>>     Passing tainted expression "*buf" to "blk_dread", which uses it as =
an offset.
940     		if (blk_dread(desc, info.start + blk, cnt, buf) !=3D cnt)
941     			goto out;
942     		if (!blk) {
943     			memcpy(stored, buf, SHA256_SUM_LEN);
944     			memset(buf, 0, SHA256_SUM_LEN);
945     		}
/drivers/fastboot/fb_command.c: 952             in flashing_unlock_allowed()
946     		sha256_update(&ctx, buf, cnt * info.blksz);
947     		last =3D buf[cnt * info.blksz - 1];
948     	}
949     	sha256_finish(&ctx, digest);
950     	allowed =3D !memcmp(stored, digest, SHA256_SUM_LEN) && last;
951     out:
>>>     CID 661187:           (TAINTED_SCALAR)
>>>     Passing tainted expression "*buf" to "dlfree", which uses it as an =
offset.
952     	free(buf);
953
954     	return allowed;
955     }
956
957     /**
/drivers/fastboot/fb_command.c: 940             in flashing_unlock_allowed()
934
935     	sha256_starts(&ctx);
936     	for (blk =3D 0; blk < info.size; blk +=3D cnt) {
937     		cnt =3D info.size - blk;
938     		if (cnt > FLASHING_FRP_CHUNK)
939     			cnt =3D FLASHING_FRP_CHUNK;
>>>     CID 661187:           (TAINTED_SCALAR)
>>>     Passing tainted expression "*buf" to "blk_dread", which uses it as =
an offset.
940     		if (blk_dread(desc, info.start + blk, cnt, buf) !=3D cnt)
941     			goto out;
942     		if (!blk) {
943     			memcpy(stored, buf, SHA256_SUM_LEN);
944     			memset(buf, 0, SHA256_SUM_LEN);
945     		}

** CID 661186:       Insecure data handling  (INTEGER_OVERFLOW)
/boot/imagemap.c: 409           in imagemap_blk_reader()


___________________________________________________________________________=
__________________
*** CID 661186:         Insecure data handling  (INTEGER_OVERFLOW)
/boot/imagemap.c: 409             in imagemap_blk_reader()
403     	 */
404     	if (desc->hwpart !=3D bp->hwpart) {
405     		blk_dselect_hwpart(desc, bp->hwpart);
406     		desc->hwpart =3D bp->hwpart;
407     	}
408
>>>     CID 661186:         Insecure data handling  (INTEGER_OVERFLOW)
>>>     "blk_dread(desc, bp->part_start + blk_off, count, buf) << desc->log=
2blksz", which might have overflowed, is returned from the function.
409     	return blk_dread(desc, bp->part_start + blk_off, count, buf)
410     	       << desc->log2blksz;
411     }
412
413     static int imagemap_probe(struct udevice *dev)
414     {

** CID 661185:         (DEADCODE)
/lib/zstd/decompress/zstd_decompress_block.c: 2123           in
ZSTD_decompressBlock_internal()
/lib/zstd/decompress/zstd_decompress_block.c: 2133           in
ZSTD_decompressBlock_internal()


___________________________________________________________________________=
__________________
*** CID 661185:           (DEADCODE)
/lib/zstd/decompress/zstd_decompress_block.c: 2123             in
ZSTD_decompressBlock_internal()
2117                     "invalid dst");
2118
2119             /* If we could potentially have long offsets, or we
might want to use the prefetch decoder,
2120              * compute information about the share of long
offsets, and the maximum nbAdditionalBits.
2121              * NOTE: could probably use a larger nbSeq limit
2122              */
>>>     CID 661185:           (DEADCODE)
>>>     Execution cannot reach the expression "totalHistorySize > 16777216U=
L" inside this statement: "if (isLongOffset || (!usePr...".
2123             if (isLongOffset || (!usePrefetchDecoder &&
(totalHistorySize > (1u << 24)) && (nbSeq > 8))) {
2124                 ZSTD_OffsetInfo const info =3D
ZSTD_getOffsetInfo(dctx->OFTptr, nbSeq);
2125                 if (isLongOffset && info.maxNbAdditionalBits <=3D
STREAM_ACCUMULATOR_MIN) {
2126                     /* If isLongOffset, but the maximum number of
additional bits that we see in our table is small
2127                      * enough, then we know it is impossible to
have too long an offset in this block, so we can
2128                      * use the regular offset decoder.
/lib/zstd/decompress/zstd_decompress_block.c: 2133             in
ZSTD_decompressBlock_internal()
2127                      * enough, then we know it is impossible to
have too long an offset in this block, so we can
2128                      * use the regular offset decoder.
2129                      */
2130                     isLongOffset =3D ZSTD_lo_isRegularOffset;
2131                 }
2132                 if (!usePrefetchDecoder) {
>>>     CID 661185:           (DEADCODE)
>>>     Execution cannot reach the expression "minShare" inside this statem=
ent: "minShare =3D (MEM_64bits() ? ...".
2133                     U32 const minShare =3D MEM_64bits() ? 7 : 20;
/* heuristic values, correspond to 2.73% and 7.81% */
2134                     usePrefetchDecoder =3D (info.longOffsetShare >=3D
minShare);
2135                 }
2136             }
2137
2138             dctx->ddictIsCold =3D 0;

** CID 661184:       Error handling issues  (CHECKED_RETURN)
/lib/zstd/common/fse.h: 509           in FSE_initDState()


___________________________________________________________________________=
__________________
*** CID 661184:         Error handling issues  (CHECKED_RETURN)
/lib/zstd/common/fse.h: 509             in FSE_initDState()
503
504     MEM_STATIC void FSE_initDState(FSE_DState_t* DStatePtr,
BIT_DStream_t* bitD, const FSE_DTable* dt)
505     {
506         const void* ptr =3D dt;
507         const FSE_DTableHeader* const DTableH =3D (const
FSE_DTableHeader*)ptr;
508         DStatePtr->state =3D BIT_readBits(bitD, DTableH->tableLog);
>>>     CID 661184:         Error handling issues  (CHECKED_RETURN)
>>>     Calling "BIT_reloadDStream" without checking return value (as is do=
ne elsewhere 4 out of 5 times).
509         BIT_reloadDStream(bitD);
510         DStatePtr->table =3D dt + 1;
511     }
512
513     MEM_STATIC BYTE FSE_peekSymbol(const FSE_DState_t* DStatePtr)
514     {

** CID 661183:       Error handling issues  (CHECKED_RETURN)
/drivers/serial/ns16550.c: 525           in ns16550_serial_probe()


___________________________________________________________________________=
__________________
*** CID 661183:         Error handling issues  (CHECKED_RETURN)
/drivers/serial/ns16550.c: 525             in ns16550_serial_probe()
519     	if (IS_ENABLED(CONFIG_NS16550_CLK_ENABLE) &&
520     	    CONFIG_IS_ENABLED(CLK)) {
521     		struct clk_bulk clk_bulk;
522
523     		ret =3D clk_get_bulk(dev, &clk_bulk);
524     		if (!ret)
>>>     CID 661183:         Error handling issues  (CHECKED_RETURN)
>>>     Calling "clk_enable_bulk" without checking return value (as is done=
 elsewhere 16 out of 20 times).
525     			clk_enable_bulk(&clk_bulk);
526     	}
527
528     	com_port->plat =3D dev_get_plat(dev);
529     	ns16550_init(com_port, -1);
530

** CID 661182:       Control flow issues  (DEADCODE)
/lib/qrcodegen_gzip.c: 28           in qrcodegen_encodeBinaryCompressed()


___________________________________________________________________________=
__________________
*** CID 661182:         Control flow issues  (DEADCODE)
/lib/qrcodegen_gzip.c: 28             in qrcodegen_encodeBinaryCompressed()
22     	if (qrcodegen_encodeBinary(dataAndTemp, dataLen, qrcode, ecl,
23     				   qrcodegen_VERSION_MIN, qrcodegen_VERSION_MAX,
24     				   qrcodegen_Mask_AUTO, true))
25     		return true;
26
27     	if (buf_max < QRGZ_MAGIC_LEN)
>>>     CID 661182:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return false;".
28     		return false;
29
30     	scratch =3D qrcode;
31     	out_len =3D buf_max;
32     	if (gzip(scratch, &out_len, dataAndTemp, dataLen) !=3D 0)
33     		return false;

** CID 661181:       Insecure data handling  (TAINTED_SCALAR)
/tools/fit_image.c: 1295           in fit_props_equal()


___________________________________________________________________________=
__________________
*** CID 661181:         Insecure data handling  (TAINTED_SCALAR)
/tools/fit_image.c: 1295             in fit_props_equal()
1289     	const void *a, *b;
1290     	int len_a, len_b;
1291
1292     	a =3D fdt_getprop(fdt, node_a, prop, &len_a);
1293     	b =3D fdt_getprop(fdt, node_b, prop, &len_b);
1294
>>>     CID 661181:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "len_a" to "memcmp", which uses it as an=
 offset. [Note: The source code implementation of the function has been ove=
rridden by a builtin model.]
1295     	return a && b && len_a =3D=3D len_b && !memcmp(a, b, len_a);
1296     }
1297
1298     /**
1299      * fit_check_shared_cipher() - Check cipher settings of
images sharing data
1300      *

** CID 661180:       Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/boot/bootm.c: 764           in bootm_zstd_uncompressed_size()


___________________________________________________________________________=
__________________
*** CID 661180:         Integer handling issues  (CONSTANT_EXPRESSION_RESUL=
T)
/boot/bootm.c: 764             in bootm_zstd_uncompressed_size()
758
759     	ret =3D zstd_get_frame_header(&hdr, src, len);
760     	if (zstd_is_error(ret) || ret > 0)
761     		return 0;
762     	if (hdr.frameContentSize =3D=3D ZSTD_CONTENTSIZE_UNKNOWN ||
763     	    hdr.frameContentSize =3D=3D ZSTD_CONTENTSIZE_ERROR ||
>>>     CID 661180:         Integer handling issues  (CONSTANT_EXPRESSION_R=
ESULT)
>>>     "hdr.frameContentSize > 18446744073709551615ULL /* 9223372036854775=
807L * 2UL + 1UL */" is always false regardless of the values of its operan=
ds. This occurs as the logical second operand of "||".
764     	    hdr.frameContentSize > ULONG_MAX)
765     		return 0;
766     	return (ulong)hdr.frameContentSize;
767     }
768     #endif
769

** CID 661179:       Integer handling issues  (INTEGER_OVERFLOW)
/test/lib/part_efi.c: 261           in lib_test_gpt_blkmap()


___________________________________________________________________________=
__________________
*** CID 661179:         Integer handling issues  (INTEGER_OVERFLOW)
/test/lib/part_efi.c: 261             in lib_test_gpt_blkmap()
255     		gpt_head =3D malloc_cache_aligned(roundup(sizeof(gpt_header),
256     							blksz));
257     		ret =3D gpt_head ? blkmap_create(GPT_TEST_LABEL, &dev) : -ENOMEM;
258     		if (ret) {
259     			free(gpt_head);
260     			free(buf);
>>>     CID 661179:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -12, overfl=
ows the type of "_val2", which is type "unsigned int".
261     			ut_assertok(ret);
262     		}
263
264     		/*
265     		 * A failed check returns early, so clean up here rather than
266     		 * in the helper. The device lives under the real dm_root, and

** CID 661178:       Control flow issues  (NO_EFFECT)
/drivers/mmc/spacemit_sdhci.c: 476           in spacemit_sdhci_execute_tuni=
ng()


___________________________________________________________________________=
__________________
*** CID 661178:         Control flow issues  (NO_EFFECT)
/drivers/mmc/spacemit_sdhci.c: 476             in
spacemit_sdhci_execute_tuning()
470     		int retry_count =3D ARRAY_SIZE(retry_delays);
471
472     		log_warning("Primary delay %d failed, trying alternatives\n",
473     			    final_delay);
474
475     		for (i =3D 0; i < retry_count; i++) {
>>>     CID 661178:         Control flow issues  (NO_EFFECT)
>>>     This greater-than-or-equal-to-zero comparison of an unsigned value =
is always true. "retry_delays[i] >=3D 0".
476     			if (retry_delays[i] >=3D SPACEMIT_RX_TUNE_DELAY_MIN &&
477     			    retry_delays[i] <=3D SPACEMIT_RX_TUNE_DELAY_MAX) {
478     				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
479     				ret =3D mmc_send_tuning(host->mmc, opcode);
480     				if (!ret) {
481     					final_delay =3D retry_delays[i];

** CID 661177:       Insecure data handling  (TAINTED_SCALAR)
/drivers/misc/spi_eeprom_emul.c: 98           in sandbox_spi_eeprom_probe()


___________________________________________________________________________=
__________________
*** CID 661177:         Insecure data handling  (TAINTED_SCALAR)
/drivers/misc/spi_eeprom_emul.c: 98             in sandbox_spi_eeprom_probe=
()
92     					  SANDBOX_SPI_EEPROM_SIZE);
93     	priv->data =3D calloc(1, priv->size);
94     	if (!priv->data)
95     		return -ENOMEM;
96
97     	/* Fill with a known pattern so reads can be verified */
>>>     CID 661177:         Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "priv->size" as a loop boundary.
98     	for (i =3D 0; i < priv->size; i++)
99     		priv->data[i] =3D i & 0xff;
100
101     	return 0;
102     }
103

** CID 661176:       Error handling issues  (CHECKED_RETURN)
/drivers/mmc/axiado_sdhci.c: 138           in axiado_sdhci_execute_tuning()


___________________________________________________________________________=
__________________
*** CID 661176:         Error handling issues  (CHECKED_RETURN)
/drivers/mmc/axiado_sdhci.c: 138             in axiado_sdhci_execute_tuning=
()
132     		sdhci_writew(host,
133     			     SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, data.blocksize=
),
134     			     SDHCI_BLOCK_SIZE);
135     		sdhci_writew(host, data.blocks, SDHCI_BLOCK_COUNT);
136     		sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
137
>>>     CID 661176:         Error handling issues  (CHECKED_RETURN)
>>>     Calling "mmc_send_cmd" without checking return value (as is done el=
sewhere 37 out of 46 times).
138     		mmc_send_cmd(mmc, &cmd, NULL);
139
140     		ctrl =3D sdhci_readw(host, SDHCI_HOST_CTRL2);
141
142     		if (cmd.cmdidx =3D=3D MMC_CMD_SEND_TUNING_BLOCK)
143     			udelay(1);

** CID 661175:       Integer handling issues  (INTEGER_OVERFLOW)
/test/boot/fit_cipher.c: 37           in fit_cipher_test_unaligned_len()


___________________________________________________________________________=
__________________
*** CID 661175:         Integer handling issues  (INTEGER_OVERFLOW)
/test/boot/fit_cipher.c: 37             in fit_cipher_test_unaligned_len()
31     	info.cipher =3D image_get_cipher_algo("aes128");
32     	ut_assertnonnull(info.cipher);
33     	info.key =3D key;
34     	info.iv =3D iv;
35
36     	ret =3D image_aes_decrypt(&info, cipher, sizeof(cipher), &data, &si=
ze);
>>>     CID 661175:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -22, overfl=
ows the type of "_val2", which is type "unsigned int".
37     	ut_asserteq(-EINVAL, ret);
38     	ut_assertnull(data);
39
40     	return 0;
41     }
42     FIT_CIPHER_TEST(fit_cipher_test_unaligned_len, 0);



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--83f5AXGC8osCg18V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat/96QAKCRAr4qD1Cr/k
CjafAQD6gWtH7GIaiCg8cNO5O0Q5urH2rzRCsDAHDHiNFx720gEAys5pBt10Kt7p
H0hhIqKzyIhfy04kO8lsulUqPEoBUQ8=
=Oo9M
-----END PGP SIGNATURE-----

--83f5AXGC8osCg18V--
