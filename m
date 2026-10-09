Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B91CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66D0781205;
	Fri,  9 Oct 2026 07:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u1XCyv1ALL4U; Fri,  9 Oct 2026 07:20:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B86281287
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530417;
	b=CGAeEZOgBlE+6Ik9JoZr24rlE3gSw972/gNCV9FmRD73DeSDkSsqA3wqJq1r5P8GWjbT
	 zApB/OWHyjENQs9li3UPON0RR4/jQ0vtlw4CMNcvoMaRcHIAEDdRQDNiqU39T6ukk0w1D
	 +D6m7m8xXjSNHFk7M6YOFx8/gWbg8mb6352kxqTONa9zeEUPK32AZ2jtUY0EydfpcpMek
	 ZS1GdIYpGB1bQlJEU/fpkEIFF0GhzwXunf0Pzbsua/zH5BODOv+fS8WHD9mnNiwLZd+gj
	 YdWknqBT4GIaifPJ5h9B6TLBFBcJ3dOiF3yqf+lDWssOG97l5Wa5x20a4pmKIt0BW/A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791530417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zmbjAUAdw0dMPGctbokp9lWDG/TvO603Tf+o9Wah4Vo=;
	b=cB2c+HmL3jJOsMHOcD3slx+blYi907Nk3Q5s/Oo38MwJbE4J6afrT31azNMNmF1gdyG/
	 x4PsqV5pwpIpmy1BGZmKCzBQOy11sP0bWUq/fx7kk6QQDrBzfJ1QNVMx//j8ojegXPMqg
	 uP5gTerVf9zfPWuRrEdsJfrjRIaAAdGs8QU9kIiHd2zeoout9c2XF4dCPCKAkJf9BV7ck
	 l16W1mVqAhYPbkvtQ0FPbvKqCRunh0Y8dCx1ppFZf2SOnL+2jsni3poiTLW4N8Zfe257E
	 iYKG3Ao2ktDEx5PniE8zX7rwNzEoSbooGNOw6IvJrlz4QRzR7C+mdoJ1c+OUYQBEUhw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791530417;
	bh=zmbjAUAdw0dMPGctbokp9lWDG/TvO603Tf+o9Wah4Vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SenWuDrTMYLgHjutRdiDfAnyxiDYMFNMjf8V0RjsQUcGGN2n4iI1nJUUKYcOuEMwu
	 8GqsntxMV5Wx8W0cn3gKyO56BABBDKfeXqzAGpV9XHUu3/a2DmK0M8ySx9LcaZ+AZq
	 6bgstb71zqHUWEQ6L867aV18xRNltLkuAjEFYjyXyFZjS2a5EqXwp0OLP7hnd02I4y
	 uNNKwqk4UkOFocmTjUgd32TRSeSCX8xGKGk+EJsqeqPYJPorrMttpIhTUzIBUst6Rm
	 GwRryLEKoAV4ZBEKoKSN3e8HSHpUHh8ZzyV9xEaELnmvtKzbcROmSg+XE5TyjtffBD
	 ALxU9wrBB9Xdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B86281287;
	Fri,  9 Oct 2026 07:20:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFEC52E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C21BB40080
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:20:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BU_r8zWofD6u for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:20:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D25B140061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530416;
 b=sOZKMe0gcmEO3b4bSijjPcYJCFo+qNSotdw2TetNSBPIr2zwemqUnepSpqiQRsCzs7By
 w2RspUAA6kI9R+udZ9QpPpUSsdLCkoZyzrbJhGv9P7mypK88He+XUCEXMtj87hhFZxQNM
 ViXkyA/5Bya/XZz7IuRQxSGCQhfyumIHFXstHKR2ux6sUmlozayNIvQVlrGmH5nLbfP8m
 jrErXGSXWEBX1Kc7EOsI65N6dBNfXz+8IENgyZmsudws8FNyPRVdBXsQHAhg5hPAQb17Y
 Pos/llOed6le8yJsCgNgDm8IMuSBLKlyTVHx9QOHjFr3ym01hdb7BsP/iG8451uBesw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791530416;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=zmbjAUAdw0dMPGctbokp9lWDG/TvO603Tf+o9Wah4Vo=;
 b=OWcyLVraxVg04Bv0BYnMgrWzitRhCOrasWrKxZYqPxaLzQaoP5vZ9p9Ev6Rd2dfcyz6A
 uVP8AHZlG3yq/voIpmpBb0MFk0qc/cT0di1XK1iXmxS2rkQK8Q1uV7wIvHzw+qTrqerIv
 Snnhy982AqJA027lxhrz6Arr4y5BCgcrVEyAZu6RuDT7NxxxSbRjUsbWBh4vtKafASmfR
 i6qcNbRW+HzZ7Abk1hlr8JmucnqWzqaE7cvvjb2e7RUi/OKLecbddHxHEOm4kZsxWC/qd
 3pMv+PyhEE7oL+kHHRaYMUK3y9lfMH2MEPUAGBNP6Vhv/gm/699swiMJ4suFeRysDog==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mdWKzJ3s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mdWKzJ3s
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D25B140061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:20:15 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6aaebeadf3cso6618914a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 00:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791530413; cv=none;
 d=google.com; s=arc-20260327;
 b=f6l8HeJU8vy0SJrL0mbvddb4TJfUl1iyjjsF7Rz+m3APyAXdYkNyIU4V5v+Sq/6EY1
 mrK78kWz5gfYWLrgFS1yVZZUsFBX6teSlCH8YjM77IB5M5rZjNXY2bSvmsyXoAvZgVfG
 iQgwmSAU4j2LTbnHfYJFGODkHMmJyJ9Zq6FmHXiQjbY6/ebpHqpFIQzw+/d5RoSJMf5x
 1kVAOcjXDHq9KTxO0yIobsGNzMC8b64Jhy4IFFFyUZFy6U5MHMH62q753YHzVG1scc2s
 z+e7CFh8QcJVbGTw/dXdoD6yFTGa2PkS9akzJm0v6dk3Nq3EZWzdBsyCI+sGyB1/Fgbw
 FahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zmbjAUAdw0dMPGctbokp9lWDG/TvO603Tf+o9Wah4Vo=;
 fh=foHa1jey+Zd3ZUQULBmfvN+OWcMIoZUPgiQ+bZgnjD4=;
 b=TEWbAydqHDISkQzFPLdLYKx1wNBb7LLJZK0QShI4C+f1QsousUa8z7tVGLij3IA3jB
 7vaPoDfIuRrA1e6M7MoybxNAy3AnTuzVL26Jbx7Rrdx7hyOSe+I/GZaZjHAqnjTGjXJJ
 pAbPKBtNjPkUFmKXSc9hU3dwN5YTwKpRooKZq8+06WbtyztuOj6Eyi78S8YSRsIgDW8r
 0fPe091KAh7f1aB5AWaLwqCvdgjGzBcA3Y/QUmPBw5TihDr4tMoO8s9wO2Qg5yYdcxZ4
 +oA6LiLFi55nvnZZ+mK8vHtfYwBpn2ASvA88XETyski0PhvqiFl5c7dD0DCYXs8Ya2Lu
 pc8Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791530413; x=1792135213;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zmbjAUAdw0dMPGctbokp9lWDG/TvO603Tf+o9Wah4Vo=;
 b=mdWKzJ3sxup+hlj8M5WhXXbDKF0l1TFRutzTYXPTy+UYs88a02SMDGU7x398Ejq3Ed
 m5tTLvU4QRWKS7zAQFdUbeOj5t7vxsjq7Ex6iqaJxONwYUnvJVvV9KAClRoaFKFQzGGn
 J0Qf3V0GDUD1izB3UzDWpxn4n2BwqAXu0Sw+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791530413; x=1792135213;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zmbjAUAdw0dMPGctbokp9lWDG/TvO603Tf+o9Wah4Vo=;
 b=V2DdOxbpmB3qPUGdU0xxOGhlV0eywZEZZWXwiyBUOGj6yqOKHtRk1rjX4GmAHiRE21
 BfsGMGrx0aN6+6ziLGBrDS2DGkUmiHE0HkUKDz2B+xaAh5om+jWt2Im3eeIfWdgY5Rz0
 2e5tSGXNAWCnX/dLeKqfkNa5Eocb1Hg10ed0r73cle2OuBadJ9VKpGPlO5lWHHP2oT5V
 6FAvIBg+aPNxHfpgxqsMsvNunFH4cf2cFnQdJE4ekjgZjLbSPoSmChGHF0ZdH+FmbquG
 7XMbZ8ejvRH1IteS0UKe6xVzVjj9yFyDlk5QXaptx6hZ7KgvpzYYRfFcYYzfIg9gteXf
 IzGQ==
X-Gm-Message-State: AFq9FYIRXQul9Sos3d4rjTRdpqoIJg5ro4Pdq8qIm1YKGxAjSLwuTT2M
 VuL3h8+Ee4C9LRPsAZp2PWYaBX3rObAdhRyctDTA31R6uBEdUZfin/8Ml9jcueNf1P0E1ZFexfQ
 lGW9/sba+dRTqSsUt9GovjjACwZIRlXWHj2n0OO6wpLs7xRMxjDlcyrBT
X-Gm-Gg: AYBFou3zU416vCzj2uGUnqnz4AMjtM6toH4HdKTAOjJ3JAP5SnZ0BvSUOkkyY6HSzda
 6HcWFSGIppDcbQwMtwH33sZLaFS7eMJ/iCGdzF2Q0Wyl9Kur7zOUUWyXofNl0p4VIUp8ru7Zjmw
 sqxwFNp/lbRU1hqRdFy2tWbpe/uz1HM/8VxsnUcmK0U9eTAI1cR18aIblm3yfMKfvtVAdY2XNQ3
 Yu4+G4UdCMaQrHipDNVce4AVrt134Y2q/FhGJVs4dfZkeEZmQl+hCuxOtp5LJHlRHE6LxYyxT0M
 kz/S+IpsY+TdHv0Qp0V2TG2rTkgLSbgoIDF5qJTpc993ZoeCZe0AIjA=
X-Received: by 2002:a05:6402:274a:b0:6a9:6944:57f2 with SMTP id
 4fb4d7f45d1cf-6b17c27b96cmr714600a12.10.1791530413299; Fri, 09 Oct 2026
 00:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-qconfigdoc-v2-1-b2338cdd8a35@gmail.com>
In-Reply-To: <20261003-qconfigdoc-v2-1-b2338cdd8a35@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 08:20:01 +0100
X-Gm-Features: AclHuK9e9WilgJKwgUBvULVFYKRxtGFOwk1qQGG39_AWd8VD0vki8izcg02X2Bk
Message-ID: <CAFLszTjZ9-u6mTdw3HN9xv1YLwS2GL7nF57wuK-=dJx0OX2kwQ@mail.gmail.com>
Subject: Re: [PATCH v2] qconfig: Improve the documentation
To: massimo.pegorer+oss@gmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Massimo,

On 2026-10-03T17:00:18, Massimo Pegorer <massimo.pegorer+oss@gmail.com> wrote:
> qconfig: Improve the documentation
>
> Specify where the database is created and under what name. Add text
> value lookup examples, including quoting, escaping and regular
> expression cases. Update other examples, or just their output, in the
> section documenting -f option usage. Trivial fixes.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>
> doc/develop/qconfig.rst | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)

> diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> @@ -81,22 +84,41 @@ Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
> -    tools/qconfig.py -f SCSI ~BLK
> -    3 matches
> -    pg_wcom_seli8_defconfig highbank_defconfig pg_wcom_expu1_defconfig
> +    ./tools/qconfig.py -f PCIE1 ~PCIE2
> +    10 matches
> +    MPC8548CDS_36BIT MPC8548CDS MPC8548CDS_legacy kmcent2

The sentence above still says 'to find boards which enabled
CONFIG_SCSI but not CONFIG_BLK', which no longer matches the example.
Please can you update it to refer to CONFIG_PCIE1 and CONFIG_PCIE2?

> diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> @@ -81,22 +84,41 @@ Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
> +String values can be searched for, too, including regular expressions, but
> +taking care of needed quoting and escaping. The values stored in the database
> +are the ones from the Kconfig files, before expansion. Moreover, since they are
> +stored with their double quotes, the quotes must be part of the pattern.

This is much clearer, thanks. One point I might have missed earlier:
the pattern must match the whole value, since defconfig_matches() uses
fullmatch(). Otherwise a reader might expect something like '"arch/.*'
to work. Please can you add a sentence about this?

Regards,
Simon
