Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B69C79FB6
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:27:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3869D80EC0;
	Sat, 12 Sep 2026 13:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8bqgElIbKwil; Sat, 12 Sep 2026 13:27:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C6A5F80E1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219649;
	b=AV8ddDWoED7Wi9Q8Z5fZkXB3VqhcTEZghGg1FJDW9/niz9yy4fXlw8lZpz2hvg+gk4sJ
	 I/+hGee0d/fbZ5ATURE14lC5yYeln/WSHtJ5gpNwE+Z6J3ftRBxRsbQVV+s3pQ3/DXlMy
	 aWdeSHCHzBPt/JNqEKn5/CMCpygUnCxSD92H81Cc+B5qG4uWUEcF0KY+/jyz2dgfkwMah
	 gXjq3vVFVbBJ544VPeBnXlhAcQj+F4VUXpLfh5Ddzaf38s9NkKun4mdAO7XtVub+5CXtI
	 9L1DaPYDuH21up4hIfCHKSAB99y3wKx7MC1dKT3c+sNmbPw4J9pd02TzfUcbvg48hDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:DKIM-Signature:Received:
	 X-Gm-Message-State:X-Received:MIME-Version:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZCWLSDTiMB21Pi5pwDOYGCU72wTPJ5QhgnkgW0b0Qls=;
	b=cpKYWcKKoeUTbgc3QGyq16V6vVjp5e/BvmpLGn0yTKM7jlJVPajX6CfgEE/skH/Vy9oS
	 okG8j5b/F9IF5BGSiuVnFugbPSXJj06t8O+w6RpOF87S/qKy7x7WfqfirmmLNfRqVX9zG
	 GfpTGpGvDzeJHPjClSF1pUKsIvuY5HefhDbQ/zNY9V+gFaQ2dkaM/LnOaMibzKAmHfCki
	 cVvbW826mQYyuG2F6su7DAs9JZMYha4z0+Hntt9ee/7hhNqvGNnWhi31KybM7JxxlKTg0
	 7K/MU46dD8p6XMCC/qJa5afS3Nluek3bbqwOI6VWMgXRiO2ZjSanSa2V0G8uTMCSW2w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219648;
	bh=ZCWLSDTiMB21Pi5pwDOYGCU72wTPJ5QhgnkgW0b0Qls=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yhtZd0rXRwoDhtvMIPqXzN5m1Uqvk5cNbEq1Ojnz9+Rq81cpA2Tm+UqRHP5mw9B4u
	 yTqCWmpHos9wZIJxI+x7K7tmoUIGMl2Yeru5W4zH9DExr9Un+Rn0VobjMl0iT6W7Ls
	 9937Xskul0InAJ4918vPa7r3/6tWKcuAA8C8fw1GFFP1cyJViSL67qEqmacqUsPbAw
	 LxLB5Hy70I+XjeHT8weBdiabTUc4I4vKRJfkmqP/KArFWgrdwvFSQ94wwDA227EOFA
	 /F5ZZ8kfqqfTJHRuDDcF4+Ieaq5FTH1s1CVN+lfs8Utj0f4U01a8x8KRQj1akTg4Ib
	 e6SzrUCqiyzHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6A5F80E1A;
	Sat, 12 Sep 2026 13:27:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD71E701
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 09:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1876406AE
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 09:58:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MTDfKmxGkJ4h for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 09:58:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BE4EF406DF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a0b:5c81:1c1::37"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789207113;
 b=Pgb77hoOgHgajbfnK8VuFitCQRIBxTw3FnWolFYKdor1GIB3dTgEyFD75V4gU8W2d57X
 qg8OGnfkF2UOW4QSozz2hbzt/J7OFtADylHoqUBnCdQccblcn9Olg4VHT4Mx0/C50nB3V
 qIWyEAX6Dial7APalpApK4WPr4s4HKosnmF3Yr96/UR9c5c/jHRcTPp0kY/wYXCYaaI2P
 nZVA4bVx1+tj2q+RJupfyDNuw6iro/ZrquT5/YMUrYO0JXeFD1juVKHQjhq8VxUmINdRh
 2dU2y48Sdemff2k0M6cgJeEMjLs/HLsoZSq3wfXCY+tShL6R3hAhas9Li+uzLBD61CA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789207113;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:
 DKIM-Signature:Received:X-Gm-Message-State:X-Received:MIME-Version:
 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=ZCWLSDTiMB21Pi5pwDOYGCU72wTPJ5QhgnkgW0b0Qls=;
 b=lIEMGVPNI/5N7KX0KAA4DirjrYAkpRscyF3Rh6ESkd0RADfYQc8KFudvomO7hTyk8PVc
 IaiGeouckimfauyUYPMZMGO3evBMNsJxHWiZxXI3J/xe4m+9d34+2IakZnnQc0LcnCNnN
 UXNa0RiHwh9fwd4A8zG8LzxBIl0HU7IDHc5JYv6Lnthnku4EJtoRCPjC0asnsPPu2ZIG/
 KErSVp43IFgp47FaSCfe6vw7zGn+A44fbX6uh9pSFNn9KMMG+kl016IynMHS9esxPg/vZ
 Yp4YWUf5SOhQ22gwT1mQ2HT3CnD2tAgkT/MZ6BPo2XoBuXVkh1DBdhnB3jhlHPUVFQQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=iki.fi; 
 dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256
 header.s=lahtoruutu header.b=lWE03V0P; 
 dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=meesny
 header.b="x2K/S2+f"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a0b:5c81:1c1::37"
X-Greylist: delayed 420 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 12 Sep 2026 09:58:32 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=iki.fi header.i=@iki.fi
 header.a=rsa-sha256 header.s=lahtoruutu header.b=lWE03V0P; 
 dkim=pass (1024-bit key,
 unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256
 header.s=meesny header.b=x2K/S2+f
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0b:5c81:1c1::37;
 helo=lahtoruutu.iki.fi; envelope-from=kalle.ahlstrom@iki.fi;
 receiver=<UNKNOWN> 
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE4EF406DF
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 09:58:32 +0000 (UTC)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4hhmrq4bQfz49PtM
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:51:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1789206683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ZCWLSDTiMB21Pi5pwDOYGCU72wTPJ5QhgnkgW0b0Qls=;
 b=lWE03V0PjaeEDwUxhV3SwPyaENgmc92yL0yfJjwBS91XbeeatXcSUFPk1U6kGoc+xx5xDw
 h+TX8jP2GWx6DoC0KnXSGMn5yZW3qW9uSyYXNnIUQZGvnRwj4W/nFHgxoT2fqoLJvaX/j3
 t5c/CsU7n/OoFbQcUtybeeFzWqcKkIJQhVa2W2wQ6uCRnfyUf5SB3gq0qyvuJLoBmbty15
 Awg4WJKNRoFi74YEKnEalmUBFCUWnGNc96X9WONoHUCfB1o3BaehIMN+2f4ZW+U31mziD+
 yxo16NAKHyFUsgUKQGf+Wh5LRK+FartEdKCMBqMI2FgAtaVAC7InBCmgmO7xAA==
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: kalle.ahlstrom@iki.fi)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4hhmrb472yzywp
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:51:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1789206671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ZCWLSDTiMB21Pi5pwDOYGCU72wTPJ5QhgnkgW0b0Qls=;
 b=x2K/S2+f4UFlKIoluh8RQQw7ITpfe659oeVRq2DFLHgZeaLa+uZ+bdW7FwMBvMAXbMCBMS
 4fLHtZUjHlOPFJZTDdc2SLp+NK2A0VOYnRgFk6m4Fxgxi2brefcN6VYuLGzHIy6NZ+mcTb
 usZXxiWLsbwGG45vHNugp0obme5I2Gk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789206671;
 b=n4PgnP2kR+5jRhBSEaorkfz7IRHvPp/oL3MzDC2jb4eumlVJMg6NU0DEHcnZDe7KuKRsaH
 R9GNH9NY3UVtHBiHsbkVTN5PSwA1GTv7LANrEK6zel8caD/6f3Y0JFJ/WCrk295ks5MrFa
 xmOwZglbtSBRC/yKObs66iDXb/Es4Yo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1789206671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ZCWLSDTiMB21Pi5pwDOYGCU72wTPJ5QhgnkgW0b0Qls=;
 b=kfzRu3AmQ0cfxTfGvyCoTavtMmZFC2CU0gLWoq/47V6a2zDuscjFJbBMnY3fBfyVcdG95Q
 CyWTawgIzHniQKc1CCAiTtkmyNkyqf5VguVciilCsK2PfJ9e6gNyuE/NsB/EWT1gizPB2M
 0qgKwaL0frEouVjnp/hfVE6qvjqIoX0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=kalle.ahlstrom@iki.fi smtp.mailfrom=kalle.ahlstrom@iki.fi
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso21211165e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 02:51:11 -0700 (PDT)
X-Gm-Message-State: AFuF++mEr90IqPislyeH961qmAtR7D0enGPha8lyoUgYPLwtwPPT4VyU
 4AuPTzztxv9SQI2emYG6aGoxeXyXUfAxIIXFl7TlAmzwYlteTogX9RoWuampg9B2JvJe1tD7qO8
 MDrbnFKPUOtmyAr2/njKM6Mr8r5xOBFA=
X-Received: by 2002:a05:600c:34d5:b0:49e:6b7c:63b4 with SMTP id
 5b1f17b1804b1-49e6b7c659dmr27421695e9.29.1789206670649; Sat, 12 Sep 2026
 02:51:10 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Kalle_Ahlstr=C3=B6m?= <kalle.ahlstrom@iki.fi>
Date: Sat, 12 Sep 2026 12:50:59 +0300
X-Gmail-Original-Message-ID: <CANnz2Sptkvz5=48DwH5L=Kr=550DB9Ob5QdD_1bvBcRgHq0W4w@mail.gmail.com>
X-Gm-Features: AcwNN1UJ82HlPrftsxXcNu7uJVIynWeFFY2D2Vmxq9gxYkQdA17oN9Z5okxOGmU
Message-ID: <CANnz2Sptkvz5=48DwH5L=Kr=550DB9Ob5QdD_1bvBcRgHq0W4w@mail.gmail.com>
Subject: USB host: multiple drivers for one composite device
To: u-boot@lists.u-boot-project.org
Cc: marex@nabladev.com, j@jannau.net
Content-Type: multipart/alternative; boundary="00000000000008ad61065b4624f5"
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:27:13 +0000
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

--00000000000008ad61065b4624f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I=E2=80=99m investigating USB boot from JetKVM on a Raspberry Pi 5 with U-B=
oot
v2026.10-rc3. JetKVM is a KVM-over-IP device that presents keyboard/mouse
HID interfaces and virtual mass storage over a single composite USB
connection.

In the device layout that comes stock with the JetKVM, storage is at
interface 4. The Pi firmware can load U-Boot from it, but U-Boot doesn=E2=
=80=99t
discover the storage. Moving storage to interface 0 allows USB EFI boot.

In usb_scan_device(), both usb_find_child() and usb_find_and_bind_driver()
receive the first interface descriptor, and one driver is bound to the
device.

I found the Apple keyboard workaround for selecting a later interface, but
haven=E2=80=99t found an example of binding both keyboard and storage drive=
rs to
one composite device. Is supporting these functions together within the
intended scope of U-Boot=E2=80=99s USB host stack?

The storage driver also assumes interface 0, and xHCI initializes only the
first two interfaces, but I=E2=80=99d like to understand the intended bindi=
ng model
first.

AI tools assisted in the investigation and drafting of this message. I have
personally read and understood relevant parts of the code mentioned above.

Kalle Ahlstr=C3=B6m

--00000000000008ad61065b4624f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I=E2=80=99m investigating USB boot from JetKVM =
on a Raspberry Pi 5 with U-Boot v2026.10-rc3. JetKVM is a KVM-over-IP devic=
e that presents keyboard/mouse HID interfaces and virtual mass storage over=
 a single composite USB connection.<br><br>In the device layout that=C2=A0c=
omes stock with the JetKVM, storage is at interface 4. The Pi firmware can =
load U-Boot from it, but U-Boot doesn=E2=80=99t discover the storage. Movin=
g storage to interface 0 allows USB EFI boot.<br><br>In usb_scan_device(), =
both usb_find_child() and usb_find_and_bind_driver() receive the first inte=
rface descriptor, and one driver is bound to the device.<br><br>I found the=
 Apple keyboard workaround for selecting a later interface, but haven=E2=80=
=99t found an example of binding both keyboard and storage drivers to one c=
omposite device. Is supporting these functions together within the intended=
 scope of U-Boot=E2=80=99s USB host stack?<br><br>The storage driver also a=
ssumes interface 0, and xHCI initializes only the first two interfaces, but=
 I=E2=80=99d like to understand the intended binding model first.<br><br>AI=
 tools assisted in the investigation and drafting of this message. I have p=
ersonally read and understood relevant parts of the code mentioned above.<b=
r><br>Kalle Ahlstr=C3=B6m</div>

--00000000000008ad61065b4624f5--
