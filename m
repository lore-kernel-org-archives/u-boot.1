Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C25EC98328
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 08:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FD9C40B11;
	Sat, 26 Sep 2026 08:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ldYxEKKBQYh; Sat, 26 Sep 2026 08:44:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C602D40B1D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790412282;
	b=eTxHVXPAKjKVHOHRYiiH7Iy9eNZxXCQX1bhxrgXBRLPrr04f/FbxyPsvta0KMT/ifHX0
	 36GTaQ9BXnuQh23/I+AXYGXcIA53LL7fjK9C/CRnOW6B+o/A2GVqVTasuqt1Zc2fVSfVv
	 AWX4WVCJSSD0h0TzD8fDgQtvQNpSyaPLmTme0ufkdJZo+QQW+RJctHfusj4tINxapaf6L
	 wm2mJL2v+BQqq3VXpX3b3IWjVT9yhnTBljyshGeZs2/gNQ0l4Z6gF2TEsrMThcc8mfLnz
	 5oQs+V8QiRM8szCtMqeFVBZR1wGYUMjppPdFtq1BMFf5CbRrMlOwrJ5pOncUW/ygSdQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790412282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3f4apbjSckUScNgs3VG3Kel28qwjkC5Tb16Qman2ttk=;
	b=b/3XM1Xj8omkjhLMkRXo9D4uMC+Hn2wu8Js94bsUM+WjaTy/E7MdcnSWrRis5m/KF+8b
	 8q8+VCvRGpGvZwDEJLtI757XZnCJ2Yvs2J1G2tfo7ASYVeJquWvsTS9q9JDpi/is39sKC
	 5RG5c1c0QU6WoxCt1vt6KjL4seqdjRU3UYo08VBJBS8WmS28k4G8XCYjoFqWmZAChV1vU
	 tPffnWArZcOzQS/67iCtK8VFrqLwMszk/5dB6Fxosg2zyZgKUUAfGPWJwj8p8r5NUYCOU
	 FZs/xOXrZVBioI3rvy1AuP9R40ScGr244i4Fm/A0z40Da+emEoUREB8TZsnsJw4ictQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790412281;
	bh=3f4apbjSckUScNgs3VG3Kel28qwjkC5Tb16Qman2ttk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h56My/zlrsdTzd5mLABhuvKnzhfau/bj+Ru2BsMKY1YQTa42QSHsvCTi6l1DLLKEu
	 NrfoQp7HMF32eJE4x1kYR6FpNmnbDG66ojN+SFIXd/Difpm0uk114evQwq4Gw2jeMW
	 2ymyHCmRj2uvKwjEntL7flL3WLQugFron8qN/PEkgVba4owRS7Pye01HP6QCIHY+hf
	 fVdYIkVDs+lD7FZMmgdjjKybciQINngicUz3ldWw0+LzpdXulL38Ep4nLZu9L40lcT
	 iJqvoodP6im9+HHHfQ8JPc4gRZ7jBiEhDki4EJgCXOBCc2rPhq13DFM+2CnmY4Ezmx
	 hoU9sU3FtR4ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C602D40B1D;
	Sat, 26 Sep 2026 08:44:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 447BF72
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 02:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A2338132B
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 02:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wz-XlzYXyvGa for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 02:54:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ACF1B8121F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790391267;
 b=MQDiuNUJkwHqMKbSgrTtKTIWsseCpUsFCJpoq+tkb1QBoclA8vRcIqZOhraDQlqMRMfB
 cePBMFQdPnmwy9u5OdxgUFEzyzsirOwlvjq9xEhBhc/BvQkeUCMNgMK+wICfvLoqPeFxp
 SD21pQViiUnJTMQB//EtE3TAElQAZrJs8n6UE6yC2s6hQ3lwWMWcbkpb4LGjbrkWTpnZv
 brbDKFyH81C497MvBbTOs+CcTe/uZj9t8+G1gb/i0Wcpj12YuXxGVHkFLyuQmOlouhoUH
 DmRbUGhjZxaTgHm6PVo+Y8H07dpGovENmk1OfE61YkoaGUhsDFhg/Js8RAtWqUSjpcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790391267;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=3f4apbjSckUScNgs3VG3Kel28qwjkC5Tb16Qman2ttk=;
 b=dxWRlT+MJffyiToWRi8JP4ZBBeTEHehj1626xT0lsLZfDkt296S3WxmIGuL7tKmSukUx
 X5OAa6ExQLM2GGW8EOv5ZRCz3lL2N+DrtZ8YuxqnjTQY71kIpbjQhRVw+j57yRViFhWiS
 zOMDRvLBS0PjatY5seniuqNy3za6cH/2uZYkoCjLTZP/zjS4qKJh8D74RnGAsXeqN8By/
 Pn4rP3QfycSFdg7AeU8Ezu7hcCArN+/14gPkeU4QW7x9iF3L66CZSGz6IDD3sG/ETxPuL
 YIVDi/O0DvhpxF2CD5V19vNzrL8ve1RuUGSZdNgEmz/lb89Mtj+E5I7LRqcz/7km2YA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iHfoVTlh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=dmanlfc@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iHfoVTlh
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACF1B8121F
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 02:54:26 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-7f4f0c89e34so963900a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 19:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790391265; cv=none;
 d=google.com; s=arc-20260327;
 b=UZGdbROslAh0Jyvoik+Ex49+ADfnd26OgHlV+qYEIRY+t2Al3LQR+CmtOZ9tnXcqp4
 syUID09JWFKe5X8psYuxi1w1oyQiZBsbZzMTUL51bs6TcqScmXl/1P0dXCepXl8006Z8
 Vxed8u6JtY+T3U2IkWbBf9A7koGIHoBtQNQvD60NuORaymntJB/wDTEFp994o1ngzxKA
 9y9YUbB90WhM6xK7DGhRWLtwdPLOpwjefU73y2/1ef0+VUaPrF+WV7BKnseJtcX+0WHg
 nUSuaf3OXbqPoaCuBvOsgCSFICo3ifTsumE6wtk5Ko3V2ZLidh08njvnd6uZXdMO/nmU
 ykVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3f4apbjSckUScNgs3VG3Kel28qwjkC5Tb16Qman2ttk=;
 fh=SLcPnvADeP08YsUIA9307GlBV3yPmlWf9A0ynSl461o=;
 b=isLG3wn5Q9tbQrIzDKP+ogl/1Akq7aFbeBukPjeQ3y5hmX7T/apzm7Ep4oNBKCE1vA
 +X4+xN4qmfbWIiGVo+KFHVSXiPx9WQyYNuQtMETvf1uEVDI7cu2tK/WrqK+OpZL85Bv5
 eqWYsJJ+O19SBPvQ9hhImd6L6wVc0x8Hvfv4TbI+UDsac1776/cgQVUYhj1ehcNJp1ow
 SJBkxtadP5whlGj0d41/3LPTsebWAujp3lyANBrSGC0Znn++FaUppzZrDSB4hNK/R2Cx
 Zr/8NvuTVI5ElJAsf4SBug5VJKzZV5yf1YSW2HVn3eDRfdzoFHKvBvy9lvc9FlJ/kNwf
 IHEA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790391265; x=1790996065;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3f4apbjSckUScNgs3VG3Kel28qwjkC5Tb16Qman2ttk=;
 b=iHfoVTlhigM1RWsKr8T/hAovKxw4vsej4qH7cqKxPjFjanYElVMuHnLFVTGYnk6ghm
 b1eav9yniw8r0ybZ9cbUYpOzUzpRhT+15O6Pe8UsirmJbTYRYMP1sy3s9zWj3eSUGCYQ
 zO63k1TRstLxJDU6Fj+YDGBM6a9SK1mJh3uAoGNOk4lK2CuCOWWOvRZRiHpKcVgAmNox
 ITfxgCykPKkt7GOzo8R7fUwVnQbepkobAMYzHftV/NSH7pUxOy42Xt/RGoWRLKm3aebV
 iIr3p922aDVgcvImAh/erJ3OF+FzZetHe6IsI2ex0ePc9jZ1f54jSKjULTn/aKSVxITx
 FnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790391265; x=1790996065;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3f4apbjSckUScNgs3VG3Kel28qwjkC5Tb16Qman2ttk=;
 b=fpqoxkxmvMhn7fwrFUXDYzP8jmRsZbN+eVaxIg0q50LqJtA5pEl8nj/O3NIP8BeZRG
 Pn1n7n4vFuavi/pbezvwsVK/BvRJgICZ3s6dNTL6i0NKH+Pru2K60HyWmiE+8lr0eI6I
 9oxwn6w5C1YEVCTUP1/jSIwbKAsMFFRU4Qi3MIiG4sqtCxPHedkzQ3d9PWWR5B0Xk+09
 4uuNvUlmki6f9YbEG2qlgaD8rslk9J7diG5E+dKN9KGbIjFo06K67KKb74kIaag6GERz
 T2dWnael7hGorHLSsZ1hf/5qG0iTR+zDN35mD69v6+to3pletaSzRKTnWb6s8NsbgzpM
 pxnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgJhAqgAkWH7WKVZlPvfGNkBgp7Pgok+oDm/IHltAU5uPCiiVuJK8a1pAmg3doHfNYdo4vvE4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n47u/VTMrXqlUDVIOqxZ6aVYfaIUIKOsnV9rb9Nsef3wccBs7x
 ILONyyMWYfTpOZ7z6YnzWDok6oro8ic31xuts9uQ0HHSsDRzbnvQ5HTuME7xTAZsIzuxrtAysx9
 oRr4tyRR5StrSrtPzFipy6juNQC6ViX8=
X-Gm-Gg: AYBFou0OWc5Cb+vu8yaLTkVtE3vqX/W/QjDg2dXq0lb6noKEyPQmVY1s83GeR5fnruk
 J0789hctLzd0xuHk/n6gbAPErvcY/rp7JJaUndOQ4Egs+PXAkJrHmkOJ3KhyvrWXM+8Hm2thOBw
 4ssZ1IALP+nZFbSspGeQkFurxfOADtdFTrmcY/4bf0kqI21luJW4g27u8XOl9ewbaPYZO1UCeuP
 d0QffRGnyJUMrjgs2XXKy12T3M50fH1sx2FIS+OPl4SIoiiy/bBkayWINLTU5zVYZHH30p2uZMl
 XfgfGQGDbe7jB88e8yNBuRl+R58haikiMuclPv9hmUiHFDd8+QoiAfUC
X-Received: by 2002:a05:6808:4fd4:b0:4b9:a8ac:488 with SMTP id
 5614622812f47-4d72df6ccc0mr9811086b6e.38.1790391265004; Fri, 25 Sep 2026
 19:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
 <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
 <PH0PR19MB997338FA72B2980A64B4194127A5DA2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd1JvBqRiuBPcLxkhF+x6yws6uOQ7z6vZqq3jrZkgj7+tg@mail.gmail.com>
 <an_Wqkp09sxijfxv@wintermute.localhost.fail>
 <PH0PR19MB9973381C3D06EF7593AE50C56DA5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd0QrejH5tR013FDOpMJu27UXf2BE1t87f9Skxm9uyLC8Q@mail.gmail.com>
 <PH0PR19MB9973381877D494D491EBAC9161A5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd2bwxO4XVApg67t8vVCOhppY1HQEi93NbCsPVOOm1RBcA@mail.gmail.com>
In-Reply-To: <CAOyTmd2bwxO4XVApg67t8vVCOhppY1HQEi93NbCsPVOOm1RBcA@mail.gmail.com>
From: Daniel Martin <dmanlfc@gmail.com>
Date: Sat, 26 Sep 2026 12:54:13 +1000
X-Gm-Features: AclHuK8w7xXWIM1JcPG_ElD0Ys7cyZv8IYEPQ1mEfQX0DSGgRoIFBdckLpAZwtI
Message-ID: <CAOyTmd2PX=94O1gLtWbRFa3EqZLhpdNDeTM-E7=V2kfP9NGOnw@mail.gmail.com>
Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 26 Sep 2026 08:44:30 +0000
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

Hi Chris,

Sorry for the late reply, lot's going on taking my time at the moment.
FYI, the updated uboot & approach worked, we have migrated it to mainline..=
.
https://github.com/batocera-linux/batocera.linux/pull/16634

Thanks!

Dan

On Tue, 18 Aug 2026 at 09:14, Daniel Martin <dmanlfc@gmail.com> wrote:
>
> Sounds good, thanks!
>
> On Tue, 18 Aug 2026 at 09:10, Chris Morgan <macromorgan@hotmail.com> wrot=
e:
> >
> > On Tue, Aug 18, 2026 at 09:04:31AM +1000, Daniel Martin wrote:
> > > That's great, thanks for the update Chris.
> > > So maybe I'm missing something...
> > > I didn't try `Arm Trusted Firmware` but I used rk3588_bl31_v1.54.elf
> > > without Optee.
> > > Does it need Optee? I assumed not as other RK3588 devices don't.
> >
> > No, it doesn't, though I boot with it anyway.
> >
> > Note that in digging through the code again I *did* find a bug and a
> > possible issue, though neither would stop the device from booting
> > successfully. I'm going to push a bugfix soon to fix the following
> > issues:
> >
> > 1) CONFIG_TARGET_GAMEFORCE_ACE_RK3588S=3Dy is not set in
> > gameforce-ace-rk3588s_defconfig, but it should be.
> >
> > 2) Since recovery from the internal eMMC isn't simple, we really should
> > set the default u-boot,spl-boot-order for this device to *always* favor
> > the external sdmmc.
> >
> > I'll push a fix upstream soon to handle these two issues, but neither
> > of them would cause a boot failure like you have experienced.
> >
> > Thank you,
> > Chris
> >
> > >
> > > Let me try again on the weekend with ATF & LInux 7.2.
> > >
> > > Dan
> > >
> > > On Tue, 18 Aug 2026 at 03:34, Chris Morgan <macromorgan@hotmail.com> =
wrote:
> > > >
> > > > On Fri, Aug 14, 2026 at 10:02:05PM -0500, Chris Morgan wrote:
> > > > > On Sat, Aug 15, 2026 at 10:06:23AM +1000, Daniel Martin wrote:
> > > > > > Thanks for the further details Chris,
> > > > > >
> > > > > > It would indeed be great if we could move this device to mainli=
ne end-to-end.
> > > > > > Let me know how you get on with v2026.07 and if possible, test =
your
> > > > > > DTS with the stable kernel (7.1.8 or similar).
> > > > > > When I reverted uboot, I encountered inconsistent I/O issues wi=
th the
> > > > > > latest stable kernel, therefore I ended up going back to the BS=
P.
> > > > > >
> > > > > > Thanks for all your work, we appreciate the effort.
> > > > > >
> > > > > > Dan
> > > > >
> > > > > I've just tested booting the device with a completely unmodified
> > > > > version of Arm Trusted Firmware (checked out at tag v2.15.0), U-B=
oot
> > > > > (checked out at tag v2026.07 and changing nothing from the
> > > > > gameforce-ace-rk3588s_defconfig), loading Linux 7.2 (tag v7.2-rc7=
) via
> > > > > extlinux boot method and it seems to be working. I do note that i=
t
> > > > > seems to be slower to boot since I upgraded A-TF and U-Boot to th=
e most
> > > > > recent releases, so I'll troubleshoot that some more next week as=
 I try
> > > > > to install a fully up to date Ubuntu 26.04 on it.
> > > > >
> > > > > I know you said it's hard to get a serial port on it, but if you
> > > > > continue to have problems booting it that might be required to
> > > > > troubleshoot it further. Otherwise I can send you my binaries if
> > > > > need be.
> > > > >
> > > > > Thank you,
> > > > > Chris
> > > >
> > > > I'm afraid I cannot seem to recreate the problem, and I'm going to =
need
> > > > a serial dump of the kernel logs. I'm sorry to ask that of you, but=
 it
> > > > will help further debug what the issue may be on your end. So far I=
've
> > > > tested using a mainline kernel (v7.2 checked out this morning), U-B=
oot
> > > > v2026.07, Arm Trusted Firmware (mainline master, checked out this
> > > > morning OR the rkbin version, rk3588_bl31_v1.54.elf), optionally wi=
th
> > > > Optee (master, checked out this morning). In each case the device b=
oots
> > > > successfully for me running Debian 13 (Forky) with my own mainline
> > > > kernel.
> > > >
> > > > I'm going to test installing Ubuntu 26.04 and fusing some OTP keys
> > > > later today, I'll let you know if I encounter further issues.
> > > >
> > > > Thank you,
> > > > Chris
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > On Sat, 15 Aug 2026 at 07:40, Christopher Morgan
> > > > > > <macromorgan@hotmail.com> wrote:
> > > > > > >
> > > > > > > I'm having trouble with my usual email client, so I'm sorry i=
f this message is formatted weird.
> > > > > > >
> > > > > > > I have tested the device most recently with 2026.04 with the =
default defconfig options. I am using mainline Arm Trusted Firmware though,=
 not the Rockchip versions. Using Rockchip's A-TF should work, but again it=
's not something I've tested. I can note that if you're using mainline A-TF=
 along with mainline Optee, you need to pass CONFIG_SPL_ATF_NO_PLATFORM_PAR=
AM=3DN, otherwise the device will fail to boot because it won't protect the=
 Optee regions. (For mainline A-TF CONFIG_SPL_ATF_NO_PLATFORM_PARAM is opti=
onal unless you use Optee, for Rockchip's BL31 you need CONFIG_SPL_ATF_NO_P=
LATFORM_PARAM=3DY).
> > > > > > >
> > > > > > > I'm going to test the device next week and see if I encounter=
 any issues with it. I'll report back if I find out anything weird.
> > > > > > >
> > > > > > > Thank you,
> > > > > > > Chris
> > > > > > > ________________________________
> > > > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > > > Sent: Wednesday, August 12, 2026 10:22 AM
> > > > > > > To: u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-proj=
ect.org>; dmanlfc@gmail.com <dmanlfc@gmail.com>
> > > > > > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > > > > > Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameFo=
rce Ace (RK3588S)
> > > > > > >
> > > > > > > +Cc Chris who maintains this board and may be able to help.
> > > > > > >
> > > > > > > I somehow didn't receive this mail in my inbox, here's my att=
empt at
> > > > > > > quoting text from a mail I didn't receive (and it's also not =
available
> > > > > > > on lore.kernel.org...).
> > > > > > >
> > > > > > >  > Hello,
> > > > > > >  >
> > > > > > >  > I am experiencing a total boot failure on the GameForce Ac=
e handheld
> > > > > > >  > console (Rockchip RK3588S) when trying to run mainline U-B=
oot
> > > > > > >  > v2026.07.
> > > > > > >  > The device fails to initialize or display any output durin=
g the
> > > > > > >  > initial handshake.
> > > > > > >  > Unfortunately, due to the tightly integrated form factor o=
f this
> > > > > > >  > handheld device, it is exceptionally difficult to break op=
en the
> > > > > > >  > casing and wire up a UART serial console to capture early =
boot logs.
> > > > > > >  > The target operating system (Batocera Linux) environment i=
s running
> > > > > > >  > the mainline Linux 7.1.5 kernel.
> > > > > > >  > Given the complete lack of visible console output, I wante=
d to check:
> > > > > > >  >
> > > > > > >  > 1. Has the GameForce Ace board target been actively tested=
 with the
> > > > > > >  > v2026.07 release?
> > > > > > >  > 2. Are there any specific or updated build instructions, B=
L31/TPL/SPL
> > > > > > >  > combinations, or proprietary Rockchip firmware binary requ=
irements
> > > > > > >  > (rkbin) needed for this release that may differ from previ=
ous
> > > > > > >  > versions?
> > > > > > >  >
> > > > > > >  > For reference, the build configuration used was: gameforce=
-ace->
> > > > > > > rk3588s_defconfig
> > > > > > >  > TF-A / BL31 version: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1=
.21.bin /
> > > > > > >  > rk3588_bl31_v1.54.elf
> > > > > > >  > Compiler: GCC 14.3
> > > > > > >  > Linux 7.1.5 uses the rk3588s-gameforce-ace.dts
> > > > > > >  >
> > > > > > >  > Any guidance on known regressions regarding this target, o=
r
> > > > > > >  > recommendations on how to isolate the stage where it hangs=
 without a
> > > > > > >  > hardware UART, would be greatly appreciated.
> > > > > > >  >
> > > > > > >
> > > > > > > If you have a known working version of U-Boot, maybe start a =
bisect with
> > > > > > > that commit as good and 2026.07 as bad to isolate a commit th=
at broke
> > > > > > > the board.
> > > > > > >
> > > > > > > Cheers,
> > > > > > > Quentin
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > >
> > > > > > Kind Regards,
> > > > > >
> > > > > > Daniel
> > >
> > >
> > >
> > > --
> > >
> > > Kind Regards,
> > >
> > > Daniel
>
>
>
> --
>
> Kind Regards,
>
> Daniel



--=20

Kind Regards,

Daniel
