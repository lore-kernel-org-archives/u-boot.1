Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCD606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FT9U1+NX;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GoDJX3OU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AC8C80E50;
	Sat, 31 Oct 2026 13:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mdYCdDqd4E4s; Sat, 31 Oct 2026 13:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 882AE80E73
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455194;
	b=oXaK7LtnDpAfp5VXuyma9/QJ34YIn9gga/tVqkG9aYyvvqq4S4mb1Zx/dCwrO1vhpNwM
	 LIxAyG0KF/XYA7qLa4iRmdi7C9MGvOK//JC6dWyKVcoLDl3RLYTi+JLbh3Y30B1GGdbhU
	 eR4gcIOJ24eQRTEoTzA7K/E6rDwWwdUykI4pF6E3UjcBJ0T0aIo8qBIUdt+H4Y2ThS74x
	 fFhGjSYr+DIrbMqvPmcR7QD16Dg+Uu/XuLlSUbz0BF7FJFJv3xLzYIblANflIub7paLgp
	 IkL8fENZIU5kEoL5nSJlewQ6rfWWnbl20OWz0PUAYsXrSe0flme+IYvZID9xZDAl4kg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=S+fr9H3sLuAeZZ5qfqjVEtshsx4FSKgfFFoNkaYisEE=;
	b=tZUZREt+gTT7RZs0i1at1JtD1wek2cScwjV0eqenc6LUpdcsTTWjfuppS/oUtg8EEmh7
	 l9aTbLUuYA5jYbAlbIPxf5EfBgrfEgVZcO9U8MmJU/FEcxIWgU9XQcsO9sRnzaC1hbnty
	 1WtmWYCtWFx5qErNy2ykL29au1QIUIhSQ9qr3SaBat3fiou8H99E0neVzNu6gGRAZbrp8
	 nvdZ82/kjl/pynuzDZaq0mRbWjRETZnljZXOcZiV5nL3fqsH9wWCYlqyOpH/85D5XqN05
	 nMgKCi0BLHCM5ZHIsVVBOFVqeniJ8YNHekpCNvLpMYSNbZsTMpI3tpk3atigkrwGLlA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455194;
	bh=S+fr9H3sLuAeZZ5qfqjVEtshsx4FSKgfFFoNkaYisEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FT9U1+NXWXMf2Ub4jHado3X3MLblORUSKDv+vIlfG5k8VCXozM/3Oss/yGiOmy7U3
	 vG01lG5oJ103vYvJZumIgtVrVgMJKGKw3QXBXYpobOVzLKXjV4DmWAFKn5XrPhypL/
	 NJ/JTHguIlUSp4uQVepNtugiLeEkYfHWWFzySVmpl8x64/3uM5yWMSisvcpAe6O40w
	 Xo/6pWCrENB3RrjwEgbHCC7/TRxApNNfnvHV7hTKhHtYqYcVd5XpVzDjeXpgpNveTQ
	 KIsNJfJpZAIRVQ+IgYavj/GyA0H+jUP8WsO3Pj39YLF0mb0+D5H/fNUbamKBOij94C
	 Jj9yPb6LgKM/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 882AE80E73;
	Sat, 31 Oct 2026 13:59:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F3ED2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1056D40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:30:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A6ox4ebAjy6D for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:30:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6D5BD40049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793446256;
 b=NxV8XwjjtBshsTH46AQpl5n53FUrFY49+DR8oQ6hoLp4UeSJrDUVbxByRVhJqMENZ/rR
 /9Kaa21+eNkz94CFhwWCX8+PJoyoJRz2nenrnd+386BzIGg431Fc5QpDyveQOup0M7MDw
 G9yPWctevR/61qRZmuEJO9uYeREYQnjn8+ziTeDqFBgSHEsygPAC5MsqW3tQ6OQmspBIN
 7HOX88A0cg+S16UWRptSny5VYrLtPuINkg8aIRwnTYSz2rNXbBwbU3vt5vdWJpNVGtdej
 rE65i8of/X/r7aVX4toLoWUJUNs9DeOGmSq+hKX6Fa23G271EhXa0L3SHIpHIlBLOzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793446256;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=S+fr9H3sLuAeZZ5qfqjVEtshsx4FSKgfFFoNkaYisEE=;
 b=beRGk29Xa0KgC7AsOCGtlihOd5skVE6v4haqdtUCyVQDpMZaYfTsR7EdWddcwn6q1ZYA
 g+q5WQkkyh3OU+ckVL0o7wqU9tCyFAsea+Mn5q/b9YTwAFt3Qn+r3Hg8P6HzXLWMy2atm
 DOqlgM+yNU4o90JAqhkdrYLF5Aj+tI1mfyeTVZF2P48pkRfPI9xGfAKGJpFptDCgS1Buz
 6xDgesF0ZQ/dQzVFmsw0mynMrDVtgiOJjAU+qIUEwGyKw6UJ2QLS0cHCkHFZ503zNLUd+
 cSJzbJlU7Mus8PRF8iw1nx2vKQuU4pOsW7JoJnd2SRHeQ22qfCTr6w02iJfmUYWi1MA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=GoDJX3OU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=nguyenanhgiau1008@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=GoDJX3OU
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D5BD40049
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:30:56 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ad98c3fb15so14203577b3.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 04:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793446255; cv=none;
 d=google.com; s=arc-20260327;
 b=BSvi8FADZwhenOcI/oZlOjmFekZqPMOiT2xMIWRoLFwgPwGvbI9o/LLM235pn28cb9
 6gMePbM4wW+FiYkmErU5VrvcQHXgH74yd0O6wq703zmP0uKO4TBVDTmA0fsuRIUNDVSS
 9sOZyIPgyaKR6AYl+/hQI4U0mIo3hDrfgy6IBXYe+B3KR5XTrhP+OqAVLqm7wCrKs0Ye
 dywoIrauar1LKyhlv/Mc7qlnJ3Il8rdUelV3K/3/+vpCZKprRHmZxKSMo+pbBnCfs+OJ
 4XKGAdVSbVWhOkhyC5/Qw4TKGJS2K92v3teKjsZq2QIbZg/k4ywBnEH7/HD4t3AjYQ1e
 h4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S+fr9H3sLuAeZZ5qfqjVEtshsx4FSKgfFFoNkaYisEE=;
 fh=xk++2mBqkPJHAPAOxquDdvoi1YTtzMD/95oFhbwO+ug=;
 b=oxkrSuX2UYFv1a/abKEoV+t9e7DmCKkEJ/1BiqpjfR/KvDSZB9IBnmixq3AYQIID9k
 L3ueYCsVFYqcVFUMiNJJiEADmFgqfL2s6UzBOmhdZAjDyO1sv644L2yXSS1H7Jljw8x4
 30lI2tunovJxh1mTGNRv8HsAMWFfV+dQvtE1JrHgR8G8n6D15pkomsGwcIsNbJ1cESmZ
 1EuqeyhgQ6xUQnhWvaaQn8TQdM/v0yfZaMUbOBu8ZJzD5GgC+4eoqCBWpmTYnaZ7QAIH
 P81km0HwlPH1itXlyDHlh/gqduJ66agt6qGtm/40i2JxKgToj2OXpKyvcdkzvAqA4WTh
 6fNw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793446255; x=1794051055;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S+fr9H3sLuAeZZ5qfqjVEtshsx4FSKgfFFoNkaYisEE=;
 b=GoDJX3OUBq7hCQDRAP1SfHjIVujpd5oJSnozlcTFm/0XKf8lQEq1UrTOduCObUkY8S
 I9EAb7b3R0xzUilmh3I6xhRQ7OKEGJchEx7jkaKyOltdvc9GawFIDY/WEJkovbA32U1n
 zsEjgkWkNYkQTyNOaLjQGKaPTB/O6BQlKj3IsKd3Oy+eNgrUqiw+ofRFlmIYavZswHf2
 FgSTGzM8jzcRvrRsDGmldFZPHHNZg9lvvqr6uJVY5jxMBWg0vTH3Lv9nWZFjgGO+UhbN
 VNktbiaD+/FtsXSA1V7b0yMkToj4Xfl7EfNU21ruaLorO3mR97iBxD5b1F61coRzb6FL
 zxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793446255; x=1794051055;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S+fr9H3sLuAeZZ5qfqjVEtshsx4FSKgfFFoNkaYisEE=;
 b=PQlGEPCFI10L+yjFXx29jWslnlNEs1Vy9kxinT9ITkx1yz8Fmu1dgGCMmfiRi0LYc3
 vJLAE+EFN+HnWHlZ1fRYJi078JQEaQ4j/bwdfq1iu5qbwQijIHaXK+dNXuyn+KDA5FkG
 iiAGlhmBnVrcjMwvg7+YAmrThNLHtsaYL749dWVU611DK4bJXA3ziKEf9hGw21yEbqK+
 66i3NThaKaU/Y0JC0mAGK/hPJQEOlQV6tzPE6kN29gbr0vU7HnuYPH95Esb0shs6YXao
 FAIV0TY1l66MYHImS0eCV39Fl79Y4rJLZ3mrfxL4tZLdEN66Xwhx0YBQJDumhF7KHBdN
 V9tA==
X-Gm-Message-State: AFq9FYJ+oP6r4nwaNmaV+KIRa27YQ/S64z+VYbwy76yNqZgLFC7IHUsd
 m59eGyzTNPjL2Q0TeE5BzEugaVE7KoTvLVSyC9naRX5idi0dqRzYjR/esJpqDIGRgJQ58Eb9KCH
 Mgn5SD+Bjq8P2R4J71r+OmmJ4utr8gWA=
X-Gm-Gg: AYBFou2rUQd/IucohpLKe5Z5cqCxUWNIF50orTQhw4ux+hECh/920zd0WYODIaUWSQ8
 bYjS/cF2IOLQjQYIEvPv26xEEj1l0OjpljPfyWZjcjspEQYzUdwSniciiEA1icriJFmDTxwavY6
 npAWHxPGlV21zNKRN1Jsbx6GvJR++A1WgoEQN7VvYlG+XJ9oZDWg3UkHpUTva880sJ3jSYzcERM
 JtTPtZQkV5tTWNZkzuCQtP52fDtAC/iZBcI6cfE6uoliBWRRHf23kFBxvBQ9u96sHjiZj+CQQD1
 Y8fy+cRAyg0j2g5PhRFYZaIGJhVWcoQH8bAQPnjndXY/RajY2QhiZSwlL+GSeT9ye4lxltwPfiB
 iqssQVPpmh5DOYLFU4nZ0bdHDQmZ9lw2Yzwr3RZaQVbhu03PSOlvkvpiwS4obVBHXo46hw9oIfG
 UbgarOuOXFySSVcJzf
X-Received: by 2002:a05:690e:458a:20b0:675:7425:2524 with SMTP id
 956f58d0204a3-67ba502d040mr2459997d50.81.1793446254682; Sat, 31 Oct 2026
 04:30:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
 <20261031065006.343477-1-nguyenanhgiau1008@gmail.com>
 <CALeDE9O_BH_GWrkhOdKTPpE-4RFxSZC19G1VA3364t9=iK_GBQ@mail.gmail.com>
In-Reply-To: <CALeDE9O_BH_GWrkhOdKTPpE-4RFxSZC19G1VA3364t9=iK_GBQ@mail.gmail.com>
From: =?UTF-8?B?R2nDoHUgTmd1eeG7hW4gQW5o?= <nguyenanhgiau1008@gmail.com>
Date: Sat, 31 Oct 2026 18:30:18 +0700
X-Gm-Features: AclHuK8puCaJF4bZgIfQruG4NPXFQDmcx7dBQeLqD0gkTB-OP232J087mhHxQyU
Message-ID: <CAKXvu5h0-cZDbtps1cJgYjHfOmA9=Unv9vWBeWw-iC5hE00Q0Q@mail.gmail.com>
Subject: Re: [PATCH v3] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller
 driver
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org, hs@nabladev.com, mbrugger@suse.com, 
 trini@konsulko.com
Content-Type: multipart/alternative; boundary="000000000000ef2545065f213e1d"
X-Mailman-Approved-At: Sat, 31 Oct 2026 13:59:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ef2545065f213e1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thanks for taking a look and for the heads-up on the defconfig!

To answer your question: I am testing this exclusively on a Raspberry Pi 4
Model B (BCM2711), as it is the only hardware generation I currently have
on hand.
The specific I2C device I am using for testing is a UPS HAT
<https://www.waveshare.com/wiki/UPS_HAT> equipped with an INA219 power
monitor/current sensor. I use it to query battery voltage and current.
The new I2C driver handles the read/write transactions with the INA219
sensor flawlessly.

Here is a quick log of the testing procedure from the U-Boot shell:
=3D> i2c dev 1
=3D> i2c probe 0x42
# Prepare calibration and config data in RAM
=3D> mw.b 0x01000000 0x39 1; mw.b 0x01000001 0x9f 1
=3D> mw.b 0x01000002 0x10 1; mw.b 0x01000003 0x00 1
# Write configurations to INA219
=3D> i2c write 0x01000000 0x42 0.1 2 -s
=3D> i2c write 0x01000002 0x42 5.1 2 -s
# Read current register (0x04)
=3D> i2c read 0x42 4.1 2 0x01000000

Regarding `rpi_arm64_defconfig`: Understood. Would you like me to send a v4
to enable CONFIG_SYS_I2C_BCM2835 in `rpi_arm64_defconfig` (and potentially
others), or should I wait for you to finish your testing across other Pi
generations so I can incorporate all feedback into v4 at once?

Looking forward to your test results.

Best regards,
Giau Nguyen
--------------------------------------------------------
Phone: (+84) 387 915 996 <+84%20387%20915%20996>


On Sat, Oct 31, 2026 at 4:32=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:

> Hi Giau,
>
> > Mainline U-Boot currently lacks an I2C controller driver for the
> > Broadcom BCM2711 SoC (Raspberry Pi 4).
>
> May I ask what i2c devices you're using to test this on U-Boot and on
> which generation of device?
>
> > This commit adds a new DM-compliant I2C driver for Broadcom
> > BCM2835/BCM2711 SoCs based on the Linux kernel's i2c-bcm2835.c.
> > (based on Linux commit 32a0a94aa09e ("i2c: Switch back to struct
> platform_driver::remove()")).
> >
> > The driver dynamically queries the actual VPU core clock rate from
> > the VideoCore firmware via mailbox property messages to calculate
> > the CDIV clock divider, ensuring accurate I2C timing and baud rates
> > on BCM2711.
> >
> > Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
>
> Typically the main config used is rpi_arm64_defconfig which covers all
> 64bit capable generations (3/4/5/Zero2).
>
> I'll test/review in the next few days for a RP
>
> > Reviewed-by: Heiko Schocher <hs@nabladev.com>
> > Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> > ---
> > v3:
> >  - Added the Linux commit ID to the commit message.
> >  - Fixed alphabetical sorting of CONFIG_SYS_I2C_BCM2835 in
> drivers/i2c/Makefile.
> >  - Added Reviewed-by tag from Heiko.
> >
> > v2:
> >  - Clarified commit message: U-Boot mainline currently lacks BCM2711 I2=
C
> driver.
> >  - Fixed line endings and code formatting per checkpatch.pl.
> >  - Converted register offsets to 'struct bcm2835_i2c_regs' abstraction.
> >  - Removed 'bcm2835_i2c_readl/writel' wrappers in favor of standard
> readl/writel.
> >  - Moved mailbox clock querying to bcm2835_get_clock_rate() in
> mach-bcm283x.
> >  - Enabled CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
> >  - Sorted drivers/i2c/Kconfig and Makefile alphabetically.
> >  - Removed 'Assisted by AI' tag.
> >
> >  MAINTAINERS                              |   1 +
> >  arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
> >  arch/arm/mach-bcm283x/msg.c              |  22 ++
> >  configs/rpi_4_defconfig                  |   4 +
> >  drivers/i2c/Kconfig                      |  10 +
> >  drivers/i2c/Makefile                     |   1 +
> >  drivers/i2c/i2c-bcm2835.c                | 370 +++++++++++++++++++++++
> >  7 files changed, 417 insertions(+)
> >  create mode 100644 drivers/i2c/i2c-bcm2835.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8c6c0c2a4bc..3260024a736 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -215,6 +215,7 @@ F:  arch/arm/dts/bcm283*
> >  F:     arch/arm/mach-bcm283x/
> >  F:     board/raspberrypi/
> >  F:     drivers/gpio/bcm2835_gpio.c
> > +F:     drivers/i2c/i2c-bcm2835.c
> >  F:     drivers/mmc/bcm2835_sdhci.c
> >  F:     drivers/mmc/bcm2835_sdhost.c
> >  F:     drivers/serial/serial_bcm283x_mu.c
> > diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h
> b/arch/arm/mach-bcm283x/include/mach/msg.h
> > index e54da86e353..d6adec07ae2 100644
> > --- a/arch/arm/mach-bcm283x/include/mach/msg.h
> > +++ b/arch/arm/mach-bcm283x/include/mach/msg.h
> > @@ -22,6 +22,15 @@ int bcm2835_power_on_module(u32 module);
> >   */
> >  int bcm2835_get_mmc_clock(u32 clock_id);
> >
> > +/**
> > + * bcm2835_get_clock_rate() - get the current rate of a clock
> > + *
> > + * @clock_id: ID of clock to get frequency for
> (BCM2835_MBOX_CLOCK_ID_...)
> > + * @rate: Returns the clock rate in Hz
> > + * Return: 0 if OK, -EIO or -EINVAL on error
> > + */
> > +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);
> > +
> >  /**
> >   * bcm2835_set_sdhost_clock() - determine if firmware controls sdhost
> cdiv
> >   *
> > diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
> > index 4993c0bdb81..74f847c5e54 100644
> > --- a/arch/arm/mach-bcm283x/msg.c
> > +++ b/arch/arm/mach-bcm283x/msg.c
> > @@ -115,6 +115,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)
> >         return clock_rate;
> >  }
> >
> > +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
> > +{
> > +       ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1)=
;
> > +       int ret;
> > +
> > +       BCM2835_MBOX_INIT_HDR(msg_clk);
> > +       BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE)=
;
> > +       msg_clk->get_clock_rate.body.req.clock_id =3D clock_id;
> > +
> > +       ret =3D bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN,
> &msg_clk->hdr);
> > +       if (ret) {
> > +               printf("bcm2835: Could not query clock rate for %u\n",
> clock_id);
> > +               return -EIO;
> > +       }
> > +
> > +       *rate =3D msg_clk->get_clock_rate.body.resp.rate_hz;
> > +       if (!*rate)
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> >  int bcm2835_set_sdhost_clock(u32 rate_hz, u32 *rate_1, u32 *rate_2)
> >  {
> >         ALLOC_CACHE_ALIGN_BUFFER(struct msg_set_sdhost_clock,
> msg_sdhost_clk, 1);
> > diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> > index f5fb322aa8f..2ddaf003558 100644
> > --- a/configs/rpi_4_defconfig
> > +++ b/configs/rpi_4_defconfig
> > @@ -22,6 +22,7 @@ CONFIG_MISC_INIT_R=3Dy
> >  CONFIG_SYS_PROMPT=3D"U-Boot> "
> >  CONFIG_CMD_DFU=3Dy
> >  CONFIG_CMD_GPIO=3Dy
> > +CONFIG_CMD_I2C=3Dy
> >  CONFIG_CMD_MMC=3Dy
> >  CONFIG_CMD_PCI=3Dy
> >  CONFIG_CMD_USB=3Dy
> > @@ -34,6 +35,9 @@ CONFIG_DM_DMA=3Dy
> >  CONFIG_DFU_MMC=3Dy
> >  CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x100000
> >  CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x200000
> > +CONFIG_I2C=3Dy
> > +CONFIG_DM_I2C=3Dy
> > +CONFIG_SYS_I2C_BCM2835=3Dy
> >  CONFIG_BCM2835_GPIO=3Dy
> >  CONFIG_MMC_SDHCI=3Dy
> >  CONFIG_MMC_SDHCI_SDMA=3Dy
> > diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> > index 52067fa7c1f..1b26906e403 100644
> > --- a/drivers/i2c/Kconfig
> > +++ b/drivers/i2c/Kconfig
> > @@ -164,6 +164,16 @@ config SYS_I2C_AT91
> >           i2c-gpio driver unless your system can cope with this
> limitation.
> >           Binding info: doc/device-tree-bindings/i2c/i2c-at91.txt
> >
> > +config SYS_I2C_BCM2835
> > +       bool "BCM2835 I2C controller"
> > +       depends on DM_I2C
> > +       help
> > +         Enable support for the Broadcom BCM2835/BCM2711 I2C controlle=
r.
> > +         This driver provides standard I2C support for Raspberry Pi
> > +         devices, including the newer Raspberry Pi 4. It dynamically
> > +         calculates the clock divider based on the VPU core clock
> > +         queried via the firmware mailbox.
> > +
> >  config SYS_I2C_IPROC
> >         bool "Broadcom I2C driver"
> >         depends on DM_I2C
> > diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> > index bebd728e7da..aac6ce4b6e0 100644
> > --- a/drivers/i2c/Makefile
> > +++ b/drivers/i2c/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_$(XPL_)SYS_I2C_LEGACY) +=3D i2c_core.o
> >  obj-$(CONFIG_SYS_I2C_ASPEED) +=3D ast_i2c.o
> >  obj-$(CONFIG_SYS_I2C_AST2600) +=3D ast2600_i2c.o
> >  obj-$(CONFIG_SYS_I2C_AT91) +=3D at91_i2c.o
> > +obj-$(CONFIG_SYS_I2C_BCM2835) +=3D i2c-bcm2835.o
> >  obj-$(CONFIG_SYS_I2C_CADENCE) +=3D i2c-cdns.o
> >  obj-$(CONFIG_SYS_I2C_CA) +=3D i2c-cortina.o
> >  obj-$(CONFIG_SYS_I2C_DAVINCI) +=3D davinci_i2c.o
> > diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> > new file mode 100644
> > index 00000000000..e6abb076bdb
> > --- /dev/null
> > +++ b/drivers/i2c/i2c-bcm2835.c
> > @@ -0,0 +1,370 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * BCM2835 I2C controller driver
> > + * (C) Copyright 2026
> > + *
> > + * Author: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> > + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
> > + */
> > +
> > +#include <log.h>
> > +#include <asm/io.h>
> > +#include <asm/arch/mbox.h>
> > +#include <asm/arch/msg.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <i2c.h>
> > +#include <time.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +
> > +#define BCM2835_I2C_C_READ     BIT(0)
> > +#define BCM2835_I2C_C_CLEAR    BIT(4) /* bits 4 and 5 both clear */
> > +#define BCM2835_I2C_C_ST       BIT(7)
> > +#define BCM2835_I2C_C_INTD     BIT(8)
> > +#define BCM2835_I2C_C_INTT     BIT(9)
> > +#define BCM2835_I2C_C_INTR     BIT(10)
> > +#define BCM2835_I2C_C_I2CEN    BIT(15)
> > +
> > +#define BCM2835_I2C_S_TA       BIT(0)
> > +#define BCM2835_I2C_S_DONE     BIT(1)
> > +#define BCM2835_I2C_S_TXW      BIT(2)
> > +#define BCM2835_I2C_S_RXR      BIT(3)
> > +#define BCM2835_I2C_S_TXD      BIT(4)
> > +#define BCM2835_I2C_S_RXD      BIT(5)
> > +#define BCM2835_I2C_S_TXE      BIT(6)
> > +#define BCM2835_I2C_S_RXF      BIT(7)
> > +#define BCM2835_I2C_S_ERR      BIT(8)
> > +#define BCM2835_I2C_S_CLKT     BIT(9)
> > +#define BCM2835_I2C_S_LEN      BIT(10) /* Fake bit for SW error
> reporting */
> > +
> > +#define BCM2835_I2C_FEDL_SHIFT 16
> > +#define BCM2835_I2C_REDL_SHIFT 0
> > +
> > +#define BCM2835_I2C_CDIV_MIN   0x0002
> > +#define BCM2835_I2C_CDIV_MAX   0xFFFE
> > +
> > +#define BCM2835_I2C_CLKT_TOUT_MS 35
> > +#define BCM2835_I2C_XFER_TIMEOUT_MS 1000
> > +
> > +struct bcm2835_i2c_regs {
> > +       u32 c;
> > +       u32 s;
> > +       u32 dlen;
> > +       u32 a;
> > +       u32 fifo;
> > +       u32 div;
> > +       u32 del;
> > +       u32 clkt;
> > +};
> > +
> > +struct bcm2835_i2c_priv {
> > +       struct bcm2835_i2c_regs __iomem *regs;
> > +       ulong input_rate;
> > +       size_t msg_buf_remaining;
> > +       u8 *msg_buf;
> > +       struct i2c_msg *curr_msg;
> > +       int msg_err;
> > +       int num_msgs;
> > +};
> > +
> > +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
> > +{
> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +
> > +       while (i2c_dev->msg_buf_remaining) {
> > +               if (!(readl(&regs->s) & BCM2835_I2C_S_TXD))
> > +                       break;
> > +
> > +               writel(*i2c_dev->msg_buf, &regs->fifo);
> > +               i2c_dev->msg_buf++;
> > +               i2c_dev->msg_buf_remaining--;
> > +       }
> > +}
> > +
> > +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
> > +{
> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +
> > +       while (i2c_dev->msg_buf_remaining) {
> > +               if (!(readl(&regs->s) & BCM2835_I2C_S_RXD))
> > +                       break;
> > +
> > +               *i2c_dev->msg_buf =3D readl(&regs->fifo);
> > +               i2c_dev->msg_buf++;
> > +               i2c_dev->msg_buf_remaining--;
> > +       }
> > +}
> > +
> > +static int bcm2835_i2c_calc_divider(unsigned long rate,
> > +                                   unsigned long parent_rate)
> > +{
> > +       int divider =3D DIV_ROUND_UP(parent_rate, rate);
> > +
> > +       /*
> > +        * Per the datasheet, the register is always interpreted as an
> even
> > +        * number, by rounding down. In other words, the LSB is ignored=
.
> So,
> > +        * if the LSB is set, increment the divider to avoid any issue.
> > +        */
> > +       if (divider & 1)
> > +               divider++;
> > +
> > +       if (divider < BCM2835_I2C_CDIV_MIN ||
> > +           divider > BCM2835_I2C_CDIV_MAX)
> > +               return -EINVAL;
> > +
> > +       return divider;
> > +}
> > +
> > +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate=
)
> > +{
> > +       struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(bus);
> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +       ulong parent_rate =3D i2c_dev->input_rate;
> > +       u32 redl, fedl;
> > +       u32 clk_tout;
> > +       int divider;
> > +
> > +       if (!rate || !parent_rate)
> > +               return -EINVAL;
> > +
> > +       divider =3D bcm2835_i2c_calc_divider(rate, parent_rate);
> > +       if (divider < 0)
> > +               return divider;
> > +
> > +       writel(divider, &regs->div);
> > +
> > +       /*
> > +        * Number of core clocks to wait after falling edge before
> > +        * outputting the next data bit. Note that both FEDL and REDL
> > +        * can't be greater than CDIV/2.
> > +        */
> > +       fedl =3D max_t(u32, divider / 16, 1);
> > +
> > +       /*
> > +        * Number of core clocks to wait after rising edge before
> > +        * sampling the next incoming data bit.
> > +        */
> > +       redl =3D max_t(u32, divider / 4, 1);
> > +
> > +       writel((fedl << BCM2835_I2C_FEDL_SHIFT) |
> > +              (redl << BCM2835_I2C_REDL_SHIFT), &regs->del);
> > +
> > +       /*
> > +        * Set the clock stretch timeout.
> > +        */
> > +       if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
> > +               clk_tout =3D 0xffff;
> > +       else
> > +               clk_tout =3D BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
> > +
> > +       writel(clk_tout, &regs->clkt);
> > +
> > +       return 0;
> > +}
> > +
> > +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_de=
v)
> > +{
> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +       u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
> > +       struct i2c_msg *msg =3D i2c_dev->curr_msg;
> > +       bool last_msg =3D (i2c_dev->num_msgs =3D=3D 1);
> > +
> > +       if (!i2c_dev->num_msgs)
> > +               return;
> > +
> > +       i2c_dev->num_msgs--;
> > +       i2c_dev->msg_buf =3D msg->buf;
> > +       i2c_dev->msg_buf_remaining =3D msg->len;
> > +
> > +       if (msg->flags & I2C_M_RD)
> > +               c |=3D BCM2835_I2C_C_READ;
> > +       else
> > +               c |=3D BCM2835_I2C_C_INTT;
> > +
> > +       if (last_msg)
> > +               c |=3D BCM2835_I2C_C_INTD;
> > +
> > +       writel(msg->addr, &regs->a);
> > +       writel(msg->len, &regs->dlen);
> > +       writel(c, &regs->c);
> > +}
> > +
> > +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv
> *i2c_dev)
> > +{
> > +       i2c_dev->curr_msg =3D NULL;
> > +       i2c_dev->num_msgs =3D 0;
> > +       i2c_dev->msg_buf =3D NULL;
> > +       i2c_dev->msg_buf_remaining =3D 0;
> > +}
> > +
> > +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs,
> int count)
> > +{
> > +       struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(dev);
> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +       bool ignore_nak =3D false;
> > +       bool done =3D false;
> > +       ulong start;
> > +       int i;
> > +       u32 val, err;
> > +       int ret =3D 0;
> > +
> > +       if (!msgs || count <=3D 0)
> > +               return -EINVAL;
> > +
> > +       for (i =3D 0; i < count; i++) {
> > +               if (msgs[i].flags & I2C_M_TEN)
> > +                       return -EOPNOTSUPP;
> > +               if (msgs[i].flags & I2C_M_RD) {
> > +                       if (i < count - 1) {
> > +                               dev_err(dev, "read message must be
> last\n");
> > +                               return -EOPNOTSUPP;
> > +                       }
> > +               }
> > +               if (msgs[i].len > 0xffff)
> > +                       return -EINVAL;
> > +               if (msgs[i].flags & I2C_M_IGNORE_NAK)
> > +                       ignore_nak =3D true;
> > +       }
> > +
> > +       /* Clear stale status and FIFO state before starting a new
> transaction. */
> > +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
> > +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR |
> BCM2835_I2C_S_DONE,
> > +              &regs->s);
> > +
> > +       i2c_dev->curr_msg =3D msgs;
> > +       i2c_dev->num_msgs =3D count;
> > +       i2c_dev->msg_err =3D 0;
> > +
> > +       bcm2835_i2c_start_transfer(i2c_dev);
> > +       start =3D get_timer(0);
> > +       while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
> > +               val =3D readl(&regs->s);
> > +
> > +               err =3D val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
> > +               if (err && !(val & BCM2835_I2C_S_TA))
> > +                       i2c_dev->msg_err =3D err;
> > +
> > +               if (val & BCM2835_I2C_S_DONE) {
> > +                       if (!i2c_dev->curr_msg) {
> > +                               dev_err(dev, "unexpected completion
> status\n");
> > +                       } else if (i2c_dev->curr_msg->flags & I2C_M_RD)=
 {
> > +                               bcm2835_drain_rxfifo(i2c_dev);
> > +                               val =3D readl(&regs->s);
> > +                       }
> > +
> > +                       if ((val & BCM2835_I2C_S_RXD) ||
> > +                           i2c_dev->msg_buf_remaining)
> > +                               i2c_dev->msg_err =3D BCM2835_I2C_S_LEN;
> > +                       done =3D true;
> > +                       break;
> > +               }
> > +
> > +               if (val & BCM2835_I2C_S_TXW) {
> > +                       if (!i2c_dev->msg_buf_remaining) {
> > +                               i2c_dev->msg_err =3D val |
> BCM2835_I2C_S_LEN;
> > +                               break;
> > +                       }
> > +
> > +                       bcm2835_fill_txfifo(i2c_dev);
> > +
> > +                       if (i2c_dev->num_msgs > 0 &&
> !i2c_dev->msg_buf_remaining) {
> > +                               i2c_dev->curr_msg++;
> > +                               bcm2835_i2c_start_transfer(i2c_dev);
> > +                       }
> > +               }
> > +
> > +               if (val & BCM2835_I2C_S_RXR) {
> > +                       if (!i2c_dev->msg_buf_remaining) {
> > +                               i2c_dev->msg_err =3D val |
> BCM2835_I2C_S_LEN;
> > +                               break;
> > +                       }
> > +
> > +                       bcm2835_drain_rxfifo(i2c_dev);
> > +               }
> > +               udelay(1);
> > +       }
> > +
> > +       if (!done) {
> > +               val =3D readl(&regs->s);
> > +               dev_err(dev, "transfer timeout: status=3D%08x
> remaining=3D%zu\n",
> > +                       val, i2c_dev->msg_buf_remaining);
> > +               ret =3D -ETIMEDOUT;
> > +       }
> > +
> > +       /* Always abort/reset the controller and clear W1C status bits.
> */
> > +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
> > +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR |
> BCM2835_I2C_S_DONE,
> > +              &regs->s);
> > +
> > +       bcm2835_i2c_finish_transfer(i2c_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (ignore_nak)
> > +               i2c_dev->msg_err &=3D ~BCM2835_I2C_S_ERR;
> > +
> > +       if (!i2c_dev->msg_err)
> > +               return 0;
> > +
> > +       if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
> > +               return -EREMOTEIO;
> > +
> > +       return -EIO;
> > +}
> > +
> > +static const struct dm_i2c_ops bcm2835_i2c_ops =3D {
> > +       .xfer          =3D bcm2835_i2c_xfer,
> > +       .set_bus_speed =3D bcm2835_i2c_set_rate,
> > +};
> > +
> > +static const struct udevice_id bcm2835_i2c_ids[] =3D {
> > +       {.compatible =3D "brcm,bcm2711-i2c"},
> > +       {.compatible =3D "brcm,bcm2835-i2c"},
> > +       {}
> > +};
> > +
> > +static int bcm2835_i2c_probe(struct udevice *bus)
> > +{
> > +       struct bcm2835_i2c_priv *priv =3D dev_get_priv(bus);
> > +       struct bcm2835_i2c_regs __iomem *regs;
> > +       unsigned int bus_clk_rate;
> > +       int ret;
> > +
> > +       priv->regs =3D dev_read_addr_ptr(bus);
> > +       if (!priv->regs) {
> > +               printf("bcm2835_i2c: cannot get base address\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       regs =3D priv->regs;
> > +
> > +       ret =3D bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK_ID_CORE,
> &priv->input_rate);
> > +       if (ret)
> > +               return ret;
> > +
> > +       bus_clk_rate =3D dev_read_u32_default(bus, "clock-frequency",
> > +                                           I2C_SPEED_STANDARD_RATE);
> > +       ret =3D bcm2835_i2c_set_rate(bus, bus_clk_rate);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* clear FIFO + status */
> > +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
> > +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR |
> BCM2835_I2C_S_DONE,
> > +              &regs->s);
> > +
> > +       return 0;
> > +}
> > +
> > +U_BOOT_DRIVER(bcm2835_i2c) =3D {
> > +       .name       =3D "bcm2835_i2c",
> > +       .id         =3D UCLASS_I2C,
> > +       .of_match   =3D bcm2835_i2c_ids,
> > +       .probe      =3D bcm2835_i2c_probe,
> > +       .priv_auto  =3D sizeof(struct bcm2835_i2c_priv),
> > +       .ops        =3D &bcm2835_i2c_ops,
> > +};
> > --
> > 2.34.1
> >
>

--000000000000ef2545065f213e1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Peter,<br><br>Th=
anks for taking a look and for the heads-up on the defconfig!<br><br>To ans=
wer your question: I am testing this exclusively on a Raspberry Pi 4 Model =
B (BCM2711), as it is the only hardware generation I currently <span style=
=3D"border-style:none;background:none">have on hand.</span>  <br>The specif=
ic I2C device I am using for testing is a <a href=3D"https://www.waveshare.=
com/wiki/UPS_HAT" target=3D"_blank">UPS HAT</a> equipped with an INA219 pow=
er monitor/current sensor. I use it to query battery voltage and current.</=
div><div>The new I2C driver handles the read/write transactions with the IN=
A219 sensor flawlessly.</div><div><br></div><div>Here is a quick log of the=
 testing procedure from the U-Boot shell:</div><div>=3D&gt; i2c dev 1</div>=
<div>=3D&gt; i2c probe 0x42</div><div># Prepare calibration and config data=
 in RAM</div><div>=3D&gt; mw.b 0x01000000 0x39 1; mw.b 0x01000001 0x9f 1</d=
iv><div>=3D&gt; mw.b 0x01000002 0x10 1; mw.b 0x01000003 0x00 1</div><div># =
Write configurations to INA219</div><div>=3D&gt; i2c write 0x01000000 0x42 =
0.1 2 -s</div><div>=3D&gt; i2c write 0x01000002 0x42 5.1 2 -s</div><div># R=
ead current register (0x04)</div><div>=3D&gt; i2c read 0x42 4.1 2 0x0100000=
0<br><br>Regarding `rpi_arm64_defconfig`: Understood. Would you like me to =
send a v4 to enable CONFIG_SYS_I2C_BCM2835 in `rpi_arm64_defconfig` (and po=
tentially others), or should I wait for you to finish your testing across o=
ther Pi generations so I can incorporate all feedback into v4 at once?<br><=
br>Looking forward to your test results.<br><br>Best regards,<br>Giau Nguye=
n</div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>----------=
----------------------------------------------</div><div>Phone: <a href=3D"=
tel:+84%20387%20915%20996" value=3D"+84387915996" target=3D"_blank">(+84) 3=
87 915 996</a><br></div></div></div></div></div></div></div></div></div></d=
iv></div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Sat, Oct 31, 2026 at 4:32=E2=80=AFPM Peter Robinson &=
lt;<a href=3D"mailto:pbrobinson@gmail.com" target=3D"_blank">pbrobinson@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi Giau,<br>
<br>
&gt; Mainline U-Boot currently lacks an I2C controller driver for the<br>
&gt; Broadcom BCM2711 SoC (Raspberry Pi 4).<br>
<br>
May I ask what i2c devices you&#39;re using to test this on U-Boot and on<b=
r>
which generation of device?<br>
<br>
&gt; This commit adds a new DM-compliant I2C driver for Broadcom<br>
&gt; BCM2835/BCM2711 SoCs based on the Linux kernel&#39;s i2c-bcm2835.c.<br=
>
&gt; (based on Linux commit 32a0a94aa09e (&quot;i2c: Switch back to struct =
platform_driver::remove()&quot;)).<br>
&gt;<br>
&gt; The driver dynamically queries the actual VPU core clock rate from<br>
&gt; the VideoCore firmware via mailbox property messages to calculate<br>
&gt; the CDIV clock divider, ensuring accurate I2C timing and baud rates<br=
>
&gt; on BCM2711.<br>
&gt;<br>
&gt; Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.<br>
<br>
Typically the main config used is rpi_arm64_defconfig which covers all<br>
64bit capable generations (3/4/5/Zero2).<br>
<br>
I&#39;ll test/review in the next few days for a RP<br>
<br>
&gt; Reviewed-by: Heiko Schocher &lt;<a href=3D"mailto:hs@nabladev.com" tar=
get=3D"_blank">hs@nabladev.com</a>&gt;<br>
&gt; Signed-off-by: Giau Nguyen &lt;<a href=3D"mailto:nguyenanhgiau1008@gma=
il.com" target=3D"_blank">nguyenanhgiau1008@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; v3:<br>
&gt;=C2=A0 - Added the Linux commit ID to the commit message.<br>
&gt;=C2=A0 - Fixed alphabetical sorting of CONFIG_SYS_I2C_BCM2835 in driver=
s/i2c/Makefile.<br>
&gt;=C2=A0 - Added Reviewed-by tag from Heiko.<br>
&gt;<br>
&gt; v2:<br>
&gt;=C2=A0 - Clarified commit message: U-Boot mainline currently lacks BCM2=
711 I2C driver.<br>
&gt;=C2=A0 - Fixed line endings and code formatting per <a href=3D"http://c=
heckpatch.pl" rel=3D"noreferrer" target=3D"_blank">checkpatch.pl</a>.<br>
&gt;=C2=A0 - Converted register offsets to &#39;struct bcm2835_i2c_regs&#39=
; abstraction.<br>
&gt;=C2=A0 - Removed &#39;bcm2835_i2c_readl/writel&#39; wrappers in favor o=
f standard readl/writel.<br>
&gt;=C2=A0 - Moved mailbox clock querying to bcm2835_get_clock_rate() in ma=
ch-bcm283x.<br>
&gt;=C2=A0 - Enabled CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.<br>
&gt;=C2=A0 - Sorted drivers/i2c/Kconfig and Makefile alphabetically.<br>
&gt;=C2=A0 - Removed &#39;Assisted by AI&#39; tag.<br>
&gt;<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 arch/arm/mach-bcm283x/include/mach/msg.h |=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 arch/arm/mach-bcm283x/msg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 22 ++<br>
&gt;=C2=A0 configs/rpi_4_defconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 drivers/i2c/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 drivers/i2c/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/i2c/i2c-bcm2835.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 370 +++++++++++++++++++++++<br>
&gt;=C2=A0 7 files changed, 417 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/i2c/i2c-bcm2835.c<br>
&gt;<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 8c6c0c2a4bc..3260024a736 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -215,6 +215,7 @@ F:=C2=A0 arch/arm/dts/bcm283*<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0 =C2=A0arch/arm/mach-bcm283x/<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0 =C2=A0board/raspberrypi/<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0 =C2=A0drivers/gpio/bcm2835_gpio.c<br>
&gt; +F:=C2=A0 =C2=A0 =C2=A0drivers/i2c/i2c-bcm2835.c<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0 =C2=A0drivers/mmc/bcm2835_sdhci.c<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0 =C2=A0drivers/mmc/bcm2835_sdhost.c<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0 =C2=A0drivers/serial/serial_bcm283x_mu.c<br>
&gt; diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-=
bcm283x/include/mach/msg.h<br>
&gt; index e54da86e353..d6adec07ae2 100644<br>
&gt; --- a/arch/arm/mach-bcm283x/include/mach/msg.h<br>
&gt; +++ b/arch/arm/mach-bcm283x/include/mach/msg.h<br>
&gt; @@ -22,6 +22,15 @@ int bcm2835_power_on_module(u32 module);<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 int bcm2835_get_mmc_clock(u32 clock_id);<br>
&gt;<br>
&gt; +/**<br>
&gt; + * bcm2835_get_clock_rate() - get the current rate of a clock<br>
&gt; + *<br>
&gt; + * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID=
_...)<br>
&gt; + * @rate: Returns the clock rate in Hz<br>
&gt; + * Return: 0 if OK, -EIO or -EINVAL on error<br>
&gt; + */<br>
&gt; +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);<br>
&gt; +<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* bcm2835_set_sdhost_clock() - determine if firmware contr=
ols sdhost cdiv<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c=
<br>
&gt; index 4993c0bdb81..74f847c5e54 100644<br>
&gt; --- a/arch/arm/mach-bcm283x/msg.c<br>
&gt; +++ b/arch/arm/mach-bcm283x/msg.c<br>
&gt; @@ -115,6 +115,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return clock_rate;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_cl=
ock_rate, msg_clk, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0BCM2835_MBOX_INIT_HDR(msg_clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0BCM2835_MBOX_INIT_TAG(&amp;msg_clk-&gt;get=
_clock_rate, GET_CLOCK_RATE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0msg_clk-&gt;get_clock_rate.body.req.clock_=
id =3D clock_id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_mbox_call_prop(BCM2835_MBO=
X_PROP_CHAN, &amp;msg_clk-&gt;hdr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;b=
cm2835: Could not query clock rate for %u\n&quot;, clock_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0*rate =3D msg_clk-&gt;get_clock_rate.body.=
resp.rate_hz;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*rate)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int bcm2835_set_sdhost_clock(u32 rate_hz, u32 *rate_1, u32 *rate=
_2)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALLOC_CACHE_ALIGN_BUFFER(struct msg_s=
et_sdhost_clock, msg_sdhost_clk, 1);<br>
&gt; diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig<br>
&gt; index f5fb322aa8f..2ddaf003558 100644<br>
&gt; --- a/configs/rpi_4_defconfig<br>
&gt; +++ b/configs/rpi_4_defconfig<br>
&gt; @@ -22,6 +22,7 @@ CONFIG_MISC_INIT_R=3Dy<br>
&gt;=C2=A0 CONFIG_SYS_PROMPT=3D&quot;U-Boot&gt; &quot;<br>
&gt;=C2=A0 CONFIG_CMD_DFU=3Dy<br>
&gt;=C2=A0 CONFIG_CMD_GPIO=3Dy<br>
&gt; +CONFIG_CMD_I2C=3Dy<br>
&gt;=C2=A0 CONFIG_CMD_MMC=3Dy<br>
&gt;=C2=A0 CONFIG_CMD_PCI=3Dy<br>
&gt;=C2=A0 CONFIG_CMD_USB=3Dy<br>
&gt; @@ -34,6 +35,9 @@ CONFIG_DM_DMA=3Dy<br>
&gt;=C2=A0 CONFIG_DFU_MMC=3Dy<br>
&gt;=C2=A0 CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x100000<br>
&gt;=C2=A0 CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x200000<br>
&gt; +CONFIG_I2C=3Dy<br>
&gt; +CONFIG_DM_I2C=3Dy<br>
&gt; +CONFIG_SYS_I2C_BCM2835=3Dy<br>
&gt;=C2=A0 CONFIG_BCM2835_GPIO=3Dy<br>
&gt;=C2=A0 CONFIG_MMC_SDHCI=3Dy<br>
&gt;=C2=A0 CONFIG_MMC_SDHCI_SDMA=3Dy<br>
&gt; diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig<br>
&gt; index 52067fa7c1f..1b26906e403 100644<br>
&gt; --- a/drivers/i2c/Kconfig<br>
&gt; +++ b/drivers/i2c/Kconfig<br>
&gt; @@ -164,6 +164,16 @@ config SYS_I2C_AT91<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c-gpio driver unless your sy=
stem can cope with this limitation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Binding info: doc/device-tree-=
bindings/i2c/i2c-at91.txt<br>
&gt;<br>
&gt; +config SYS_I2C_BCM2835<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;BCM2835 I2C controller&quot;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on DM_I2C<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Enable support for the Broadcom BCM=
2835/BCM2711 I2C controller.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver provides standard I2C s=
upport for Raspberry Pi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devices, including the newer Raspbe=
rry Pi 4. It dynamically<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0calculates the clock divider based =
on the VPU core clock<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queried via the firmware mailbox.<b=
r>
&gt; +<br>
&gt;=C2=A0 config SYS_I2C_IPROC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Broadcom I2C driver&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on DM_I2C<br>
&gt; diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile<br>
&gt; index bebd728e7da..aac6ce4b6e0 100644<br>
&gt; --- a/drivers/i2c/Makefile<br>
&gt; +++ b/drivers/i2c/Makefile<br>
&gt; @@ -14,6 +14,7 @@ obj-$(CONFIG_$(XPL_)SYS_I2C_LEGACY) +=3D i2c_core.o<=
br>
&gt;=C2=A0 obj-$(CONFIG_SYS_I2C_ASPEED) +=3D ast_i2c.o<br>
&gt;=C2=A0 obj-$(CONFIG_SYS_I2C_AST2600) +=3D ast2600_i2c.o<br>
&gt;=C2=A0 obj-$(CONFIG_SYS_I2C_AT91) +=3D at91_i2c.o<br>
&gt; +obj-$(CONFIG_SYS_I2C_BCM2835) +=3D i2c-bcm2835.o<br>
&gt;=C2=A0 obj-$(CONFIG_SYS_I2C_CADENCE) +=3D i2c-cdns.o<br>
&gt;=C2=A0 obj-$(CONFIG_SYS_I2C_CA) +=3D i2c-cortina.o<br>
&gt;=C2=A0 obj-$(CONFIG_SYS_I2C_DAVINCI) +=3D davinci_i2c.o<br>
&gt; diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..e6abb076bdb<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/i2c/i2c-bcm2835.c<br>
&gt; @@ -0,0 +1,370 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0<br>
&gt; +/*<br>
&gt; + * BCM2835 I2C controller driver<br>
&gt; + * (C) Copyright 2026<br>
&gt; + *<br>
&gt; + * Author: Giau Nguyen &lt;<a href=3D"mailto:nguyenanhgiau1008@gmail.=
com" target=3D"_blank">nguyenanhgiau1008@gmail.com</a>&gt;<br>
&gt; + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;log.h&gt;<br>
&gt; +#include &lt;asm/io.h&gt;<br>
&gt; +#include &lt;asm/arch/mbox.h&gt;<br>
&gt; +#include &lt;asm/arch/msg.h&gt;<br>
&gt; +#include &lt;dm.h&gt;<br>
&gt; +#include &lt;dm/device_compat.h&gt;<br>
&gt; +#include &lt;i2c.h&gt;<br>
&gt; +#include &lt;time.h&gt;<br>
&gt; +#include &lt;linux/bitops.h&gt;<br>
&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; +#include &lt;linux/err.h&gt;<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/types.h&gt;<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_C_READ=C2=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; +#define BCM2835_I2C_C_CLEAR=C2=A0 =C2=A0 BIT(4) /* bits 4 and 5 both =
clear */<br>
&gt; +#define BCM2835_I2C_C_ST=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(7)<br>
&gt; +#define BCM2835_I2C_C_INTD=C2=A0 =C2=A0 =C2=A0BIT(8)<br>
&gt; +#define BCM2835_I2C_C_INTT=C2=A0 =C2=A0 =C2=A0BIT(9)<br>
&gt; +#define BCM2835_I2C_C_INTR=C2=A0 =C2=A0 =C2=A0BIT(10)<br>
&gt; +#define BCM2835_I2C_C_I2CEN=C2=A0 =C2=A0 BIT(15)<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_S_TA=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; +#define BCM2835_I2C_S_DONE=C2=A0 =C2=A0 =C2=A0BIT(1)<br>
&gt; +#define BCM2835_I2C_S_TXW=C2=A0 =C2=A0 =C2=A0 BIT(2)<br>
&gt; +#define BCM2835_I2C_S_RXR=C2=A0 =C2=A0 =C2=A0 BIT(3)<br>
&gt; +#define BCM2835_I2C_S_TXD=C2=A0 =C2=A0 =C2=A0 BIT(4)<br>
&gt; +#define BCM2835_I2C_S_RXD=C2=A0 =C2=A0 =C2=A0 BIT(5)<br>
&gt; +#define BCM2835_I2C_S_TXE=C2=A0 =C2=A0 =C2=A0 BIT(6)<br>
&gt; +#define BCM2835_I2C_S_RXF=C2=A0 =C2=A0 =C2=A0 BIT(7)<br>
&gt; +#define BCM2835_I2C_S_ERR=C2=A0 =C2=A0 =C2=A0 BIT(8)<br>
&gt; +#define BCM2835_I2C_S_CLKT=C2=A0 =C2=A0 =C2=A0BIT(9)<br>
&gt; +#define BCM2835_I2C_S_LEN=C2=A0 =C2=A0 =C2=A0 BIT(10) /* Fake bit for=
 SW error reporting */<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_FEDL_SHIFT 16<br>
&gt; +#define BCM2835_I2C_REDL_SHIFT 0<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_CDIV_MIN=C2=A0 =C2=A00x0002<br>
&gt; +#define BCM2835_I2C_CDIV_MAX=C2=A0 =C2=A00xFFFE<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_CLKT_TOUT_MS 35<br>
&gt; +#define BCM2835_I2C_XFER_TIMEOUT_MS 1000<br>
&gt; +<br>
&gt; +struct bcm2835_i2c_regs {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 s;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dlen;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 a;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 fifo;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 div;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 del;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 clkt;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct bcm2835_i2c_priv {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ulong input_rate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t msg_buf_remaining;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *msg_buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_msg *curr_msg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int msg_err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int num_msgs;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D =
i2c_dev-&gt;regs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0while (i2c_dev-&gt;msg_buf_remaining) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(readl(&a=
mp;regs-&gt;s) &amp; BCM2835_I2C_S_TXD))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(*i2c_de=
v-&gt;msg_buf, &amp;regs-&gt;fifo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;ms=
g_buf++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;ms=
g_buf_remaining--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D =
i2c_dev-&gt;regs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0while (i2c_dev-&gt;msg_buf_remaining) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(readl(&a=
mp;regs-&gt;s) &amp; BCM2835_I2C_S_RXD))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*i2c_dev-&gt;m=
sg_buf =3D readl(&amp;regs-&gt;fifo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;ms=
g_buf++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;ms=
g_buf_remaining--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int bcm2835_i2c_calc_divider(unsigned long rate,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long paren=
t_rate)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int divider =3D DIV_ROUND_UP(parent_rate, =
rate);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Per the datasheet, the register is alwa=
ys interpreted as an even<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * number, by rounding down. In other word=
s, the LSB is ignored. So,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * if the LSB is set, increment the divide=
r to avoid any issue.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (divider &amp; 1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0divider++;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (divider &lt; BCM2835_I2C_CDIV_MIN ||<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0divider &gt; BCM2835_I2C_CDI=
V_MAX)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return divider;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rat=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_priv *i2c_dev =3D dev_g=
et_priv(bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D =
i2c_dev-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ulong parent_rate =3D i2c_dev-&gt;input_ra=
te;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 redl, fedl;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 clk_tout;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int divider;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rate || !parent_rate)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0divider =3D bcm2835_i2c_calc_divider(rate,=
 parent_rate);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (divider &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return divider=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(divider, &amp;regs-&gt;div);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Number of core clocks to wait after fal=
ling edge before<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * outputting the next data bit. Note that=
 both FEDL and REDL<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * can&#39;t be greater than CDIV/2.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fedl =3D max_t(u32, divider / 16, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Number of core clocks to wait after ris=
ing edge before<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * sampling the next incoming data bit.<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0redl =3D max_t(u32, divider / 4, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel((fedl &lt;&lt; BCM2835_I2C_FEDL_SHI=
FT) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (redl &lt;&lt; BCM28=
35_I2C_REDL_SHIFT), &amp;regs-&gt;del);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set the clock stretch timeout.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rate &gt; 0xffff * 1000 / BCM2835_I2C_=
CLKT_TOUT_MS)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_tout =3D 0=
xffff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_tout =3D B=
CM2835_I2C_CLKT_TOUT_MS * rate / 1000;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(clk_tout, &amp;regs-&gt;clkt);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_d=
ev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D =
i2c_dev-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C=
_I2CEN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_msg *msg =3D i2c_dev-&gt;curr_m=
sg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool last_msg =3D (i2c_dev-&gt;num_msgs =
=3D=3D 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!i2c_dev-&gt;num_msgs)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;num_msgs--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf =3D msg-&gt;buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_remaining =3D msg-&gt;=
len;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (msg-&gt;flags &amp; I2C_M_RD)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c |=3D BCM2835=
_I2C_C_READ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c |=3D BCM2835=
_I2C_C_INTT;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (last_msg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c |=3D BCM2835=
_I2C_C_INTD;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(msg-&gt;addr, &amp;regs-&gt;a);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(msg-&gt;len, &amp;regs-&gt;dlen);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(c, &amp;regs-&gt;c);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_=
dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;curr_msg =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;num_msgs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_remaining =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs=
, int count)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_priv *i2c_dev =3D dev_g=
et_priv(dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D =
i2c_dev-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool ignore_nak =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool done =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ulong start;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 val, err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!msgs || count &lt;=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; count; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].fl=
ags &amp; I2C_M_TEN)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -EOPNOTSUPP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].fl=
ags &amp; I2C_M_RD) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (i &lt; count - 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;read message m=
ust be last\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].le=
n &gt; 0xffff)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].fl=
ags &amp; I2C_M_IGNORE_NAK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ignore_nak =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Clear stale status and FIFO state befor=
e starting a new transaction. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_C_CLEAR, &amp;regs-&gt;=
c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_=
ERR | BCM2835_I2C_S_DONE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;regs-&gt;s);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;curr_msg =3D msgs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;num_msgs =3D count;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_i2c_start_transfer(i2c_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0start =3D get_timer(0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0while (get_timer(start) &lt; BCM2835_I2C_X=
FER_TIMEOUT_MS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(=
&amp;regs-&gt;s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D val &a=
mp; (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &amp;&=
amp; !(val &amp; BCM2835_I2C_S_TA))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; =
BCM2835_I2C_S_DONE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!i2c_dev-&gt;curr_msg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;unexpected com=
pletion status\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0} else if (i2c_dev-&gt;curr_msg-&gt;flags &amp; I2C_M_RD) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_drain_rxfifo(i2c_dev);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(&amp;regs-&gt;s);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if ((val &amp; BCM2835_I2C_S_RXD) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_remaining)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D BCM2835_I=
2C_S_LEN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0done =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; =
BCM2835_I2C_S_TXW) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!i2c_dev-&gt;msg_buf_remaining) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D val | BCM=
2835_I2C_S_LEN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0bcm2835_fill_txfifo(i2c_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (i2c_dev-&gt;num_msgs &gt; 0 &amp;&amp; !i2c_dev-&gt;msg_b=
uf_remaining) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;curr_msg++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_i2c_start_transfer(i2c_de=
v);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; =
BCM2835_I2C_S_RXR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!i2c_dev-&gt;msg_buf_remaining) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D val | BCM=
2835_I2C_S_LEN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0bcm2835_drain_rxfifo(i2c_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!done) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(=
&amp;regs-&gt;s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &=
quot;transfer timeout: status=3D%08x remaining=3D%zu\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0val, i2c_dev-&gt;msg_buf_remaining);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ETIME=
DOUT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Always abort/reset the controller and c=
lear W1C status bits. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_C_CLEAR, &amp;regs-&gt;=
c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_=
ERR | BCM2835_I2C_S_DONE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;regs-&gt;s);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_i2c_finish_transfer(i2c_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ignore_nak)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;ms=
g_err &amp;=3D ~BCM2835_I2C_S_ERR;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!i2c_dev-&gt;msg_err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (i2c_dev-&gt;msg_err &amp; BCM2835_I2C_=
S_ERR)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EREMOT=
EIO;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dm_i2c_ops bcm2835_i2c_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.xfer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D bcm2835_i2c_xfer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_bus_speed =3D bcm2835_i2c_set_rate,<b=
r>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct udevice_id bcm2835_i2c_ids[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{.compatible =3D &quot;brcm,bcm2711-i2c&qu=
ot;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{.compatible =3D &quot;brcm,bcm2835-i2c&qu=
ot;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int bcm2835_i2c_probe(struct udevice *bus)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_priv *priv =3D dev_get_=
priv(bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int bus_clk_rate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0priv-&gt;regs =3D dev_read_addr_ptr(bus);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!priv-&gt;regs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;b=
cm2835_i2c: cannot get base address\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0regs =3D priv-&gt;regs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_get_clock_rate(BCM2835_MBO=
X_CLOCK_ID_CORE, &amp;priv-&gt;input_rate);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bus_clk_rate =3D dev_read_u32_default(bus,=
 &quot;clock-frequency&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0I2C_SPEED_STANDARD_RATE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_i2c_set_rate(bus, bus_clk_=
rate);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* clear FIFO + status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_C_CLEAR, &amp;regs-&gt;=
c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_=
ERR | BCM2835_I2C_S_DONE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;regs-&gt;s);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +U_BOOT_DRIVER(bcm2835_i2c) =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;=
bcm2835_i2c&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D U=
CLASS_I2C,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match=C2=A0 =C2=A0=3D bcm2835_i2c_ids,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =3D bcm2835_i2c=
_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.priv_auto=C2=A0 =3D sizeof(struct bcm2835=
_i2c_priv),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.ops=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &amp;b=
cm2835_i2c_ops,<br>
&gt; +};<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
</blockquote></div></div>
</div>

--000000000000ef2545065f213e1d--
