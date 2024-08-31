Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64F5CA101C
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 12:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC75288440;
	Sat, 31 Aug 2024 14:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K3tZAQ9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D1E48855C; Sat, 31 Aug 2024 14:06:48 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8267187DC7
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 14:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=al.kochet@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f401c20b56so31839151fa.0
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725106005; x=1725710805; darn=lists.denx.de;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=i62QYSa1Pwv1B7wp5FHDdBDIxBB1n9yEpuRyEq/ctxQ=;
 b=K3tZAQ9ogjBoYrafY9vqwVlLO1tyxHkzcJsJUKhkggbjpCm5usY4kmjnABd4KGqXUI
 3Q05phUpdqg/Q1xE4JJtdYcM4Ql4YWBpHdC4eciN5X164b+lGzMwRH+vyFkn+77oif2a
 HLuN+sL0qb4pFSal3w4MSZ8c7IUCF4MyXb/zh1LSpVFzvHOTVUALQgJ60olFOkeAVO5u
 zn8dQdoeunHp/vUFViy/Mnf0yjK9WuHJHRrRGVSbO9uBqNw7IC6XirnzlEPlnu6GyGCA
 21+L8Csf3DJOiZJk5GnxlNAYhaRXChTXfAAqPqJ8whf+kY2CFjkV5xmqQFWPh6gRLmgq
 qyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725106005; x=1725710805;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i62QYSa1Pwv1B7wp5FHDdBDIxBB1n9yEpuRyEq/ctxQ=;
 b=UFcerDj0LqXVZDUfXwJ6w6gxqESih8l1ojdN9G4rfM1XPfG4SrWGrlOsJZCvzUsrlv
 noxbg1+jt+YMyi8MeQlrCQGWfMSzJrEpOU2FnqRNR3hEYOzJUt1roOOKLMThowTm3q5l
 wG592uv2T7x1IH3z6UNbqLR9hpOG1/gD9fnls/uYn0cVbcBb4TQxi1xM3ASj0CAR0CfI
 IfbhZimLCgMU9hSE0wT7cKv6pvqt0bmsrUQqjcAnPUzqkZoGOcZ/0jJd7zqW6gIR+kJu
 Laeb1daTtGsfGvdL1Lm+m6SxIVMA0Mb5f1dlWNkkfE0eGFYhG1fzMUjTOELDVzw+QJeX
 q1NQ==
X-Gm-Message-State: AOJu0YxnO06tIfHHg/IXLmI5gEbRgOLqUgb+sHZwIBgd+G5TlvB3m0XH
 GE+l9XAPHahNQ1twk6cCEMYYFwX7qm7DjCSnYGlXjs/LsSqIfnG2wBTdGg==
X-Google-Smtp-Source: AGHT+IH6zfj8rrIlX6seyb318DEtmi/7E4WtQzDoBqzZa1XVFxO1SPvBqhnDlDHRqgl9krXiRwJs1A==
X-Received: by 2002:a05:6512:239c:b0:52e:8161:4ce6 with SMTP id
 2adb3069b0e04-5354634774fmr1834127e87.25.1725106004620; 
 Sat, 31 Aug 2024 05:06:44 -0700 (PDT)
Received: from smtpclient.apple (95-24-48-192.broadband.corbina.ru.
 [95.24.48.192]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5354084cb51sm944604e87.254.2024.08.31.05.06.43
 for <u-boot@lists.denx.de>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 31 Aug 2024 05:06:44 -0700 (PDT)
From: Alexander Kochetkov <al.kochet@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: What is the proper way to sign fit images using binman/mkimage for
 verified boot
Message-Id: <339DE2F4-312A-4817-85E8-A2F88125196D@gmail.com>
Date: Sat, 31 Aug 2024 15:06:33 +0300
To: U-Boot Mailing List <u-boot@lists.denx.de>
X-Mailer: Apple Mail (2.3776.700.51)
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

Hello!

I used to sign images for verified boot for u-boot v2020.04 for =
allwinner A64-based board. It was simple.
I=E2=80=99ve just added signature nodes for atf, u-boot, dtb, =
configurations to the generated by mksunxi_fit_atf.sh
its file and mkimage signed the fit image.

Now I trying to do the same for u-boot v2024.07. I work with Radxa Model =
3a. It=E2=80=99s fit image is generated
using binman. It=E2=80=99s bimnan configuration is located in the file =
arch/arm/dts/rockchip-u-boot.dtsi.

I have 3 ideas about how to get the job done:
- improve binman, to support signing fit images during fit image =
generation. Sort of implementing
  image-signature etype
- fix mkimage to allow signing generated by binman images. Now I getting =
error, then I try to do that
- may be I do the job in a wrong way? Could you please direct me in a =
correct way?

First I think, that I have to add signature entries to binman =
configuration. So, I added following:

&binman {
    simple-bin {
        =E2=80=A6
        fit: fit {
            =E2=80=A6
            images {
                =E2=80=A6
                @atf-SEQ {
                     =E2=80=A6
                     signature {
                         algo =3D "sha256,rsa2048=C2=BB;
                         key-name-hint =3D "uboot-spl=C2=BB;
                         sign-images =3D "atf-SEQ=C2=BB;
                    };
                };
            };
        };
    };
};

This signature entry was copied to resulted fit image without =
processing. No signature was generated.
SEQ was not replaced to 1:

atf-1 {
    ...
    hash {
        value =3D <0xb5946ac6 0x3df8fb35 0x69407a75 0xcf2f6aa3 =
0x96551ba0 0x11e1a84b 0xec654dc9 0x982ba063>;
        algo =3D "sha256=C2=BB;
    };

    signature {
        algo =3D "sha256,rsa2048=C2=BB;
        key-name-hint =3D "uboot-spl=C2=BB;
        sign-images =3D "atf-SEQ=C2=BB;
    };
};

So, obviously binman is not support this way of signing images. If this =
way looks reasonable, I can try to implement
it and send patches to u-boot. I played with binman etypes, tryied to =
add custom 'image-signature' etype. Looks like I
can complete such work.

Second solution looks for me as follows. We need run mkimage to sign =
generated by binman fit image.
Some sort of running mkimage like this:

./tools/mkimage -k /media/yocto/build-yocto/=E2=80=A6. -F ./u-boot.itb

Now I getting error then I run mkimage:
Can't add verification data for node 'atf-1' (<unknown error>)

If that solution is reasonable, I can fix <unknown error> and send =
patches.

Third thought, may be there is another proper way to sign fit image for =
verified boot?
Could you please provide an idea how to do that.

Regards,
Alexander.

