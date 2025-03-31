Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E90CC36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D828129B;
	Mon, 31 Mar 2025 19:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kohlschutter.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kohlschuetter-com.20230601.gappssmtp.com header.i=@kohlschuetter-com.20230601.gappssmtp.com header.b="tp1NBdqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376288171B; Mon, 31 Mar 2025 19:31:25 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED69E81026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=kohlschutter.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian@kohlschuetter.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso953313566b.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kohlschuetter-com.20230601.gappssmtp.com; s=20230601; t=1743442282;
 x=1744047082; darn=lists.denx.de; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmGyVPBpBS8UvNv2a+cmazNybo+GSwNVtE4Qs7Wv1p8=;
 b=tp1NBdqQNlrroNw1q2qKLn7h5pX/+suC4fMzKUfgGJjK8N+2O0bd7wcle0mSA5sz+Q
 Cuc9q1QOAZ2FZNTTBecaIWfVv0aVA0PqRAjOZzvfv2aZJ/O4Glz0xZ8qx56pgzzwJ4n/
 INfY+rKH6ke3ohLcfH+guVAyFa/Umlic6em5ExFaN1HiQRdSSDdTwEgou9VP09eAuWOb
 eo83mEXwGLG5FE6tqvvb+4iDWBCSTGrAGyxqQ4ioZdGvkWgZsCrdwEsyXwad1Li3496T
 D78YiUrZgDAjyUnJIv4jrkDnyzcSoddLXBvr2tjZhIDNcstmC/lumxAIQuDud5QQj3qH
 xPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743442282; x=1744047082;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmGyVPBpBS8UvNv2a+cmazNybo+GSwNVtE4Qs7Wv1p8=;
 b=NpDuektPp3VyIVMxeCiipa98FxOAtcmUsDZlnLmNuLIMByHxDAHaX4NwsfoJyHJ5/V
 qpK949MQG/0WAEgo+IxSPC8HJkxXVMvTbtHrXGvrcAgCZE5OcX5EBgXrbLl70Y7wy7VJ
 adqcAJkBLpjMnFBCt2bImceypwilQP4iafSnF0VHiuqBf940vTxG/FHZBHCVDN8fOgyE
 KvWXhnMKxyLOTbX9QvoCqmz8Yi6UCVtJO0g5jOVoYeHOg3JrGvxpsyXdGRgk1IcyNbqF
 z7LJH+C99r/hKxiWMt7AxUtmx9/oNIsak/YDf3BEQf5Yk/uQRFwu2qJy9n6XpGy1yr6v
 WW8A==
X-Gm-Message-State: AOJu0YwT78GTg3KmmvtcA2OOZG0dHof1fjzrb+sTMFdWEvC63RMlzzjD
 HNAtgksqMcVaQ2QTjgg2rSal4ykrSbeuZraGDHWnPYyrHc2BfIRntXtGDGLUb3BVrwLO1TJz1eM
 Y/1E=
X-Gm-Gg: ASbGncsJcKzqAkxhHXqoEQEMAlq63ftfdxn8+qRrn+v/fmkWF3g8nU8IytGdRv96uIF
 UTJI9Zo5orOBuAqlFYMgheiTj4Y+RdVnqyAkDFaYCAqSzhW7QANC57qNNY+F6SZXOIhcgDOQk4z
 euewEG70lyockfLGs2Tho0Sfb6YEFvTV6w6smro+k2AobtcAZuy/jRegmHq39yL44Gxhf5fQ25e
 TqHRqOkYX6Km4G/fURSwS/zGozwzH1hNpSpiryul5qZhALNxHakG+67arbVyO3za57KsZa2y/u3
 d+ZMqZ175e85rjIipfGtQfSCJWQtcTn+G/fCKqhU9015C72rETDbsh5BETB/OdZihg0KEbnrrnN
 faQE=
X-Google-Smtp-Source: AGHT+IHCAZmd3mBC/QllddfAhBZx1HmwmYtuAdwgSyb5sFdEcsUF7tGOcCRKZWcoL5CENdtqL97gTQ==
X-Received: by 2002:a17:907:3d8f:b0:ac6:edd3:e466 with SMTP id
 a640c23a62f3a-ac7389fccd5mr856163466b.19.1743442269280; 
 Mon, 31 Mar 2025 10:31:09 -0700 (PDT)
Received: from smtpclient.apple ([91.64.76.218])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71961f0cfsm648163766b.116.2025.03.31.10.31.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Mar 2025 10:31:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: =?utf-8?Q?Re=3A_U-Boot_interferes_with_initrd_binary_=E2=80=94_Re?=
 =?utf-8?Q?vert_=22efi=3A_Correct_smbios-table_installation=22_=3F?=
From: =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
In-Reply-To: <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
Date: Mon, 31 Mar 2025 19:31:00 +0200
Cc: u-boot@lists.denx.de,
 sjg@chromium.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
To: Michael Brown <mcb30@ipxe.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
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

On 31. Mar 2025, at 19:15, Michael Brown <mcb30@ipxe.org> wrote:
>=20
> On 31/03/2025 17:49, Christian Kohlsch=C3=BCtter wrote:
>> # hexdump  /.aaaaargh
>> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
>> *
>> 0044100 ffff ffff ffff 15dc f9c8 6f16 e188 0000
>> 0044110 00a0 52b0 a01c 6d59 0000 0000 0000 0000
>> 0044120 0000 0000 0000 0000 0000 0000 0000 0000
>> 0044130 0000 0000 0000 0000 0000 0000 e1a8 6097
>=20
> This looks suspiciously like a broadcast Ethernet packet from a source =
MAC address of dc:15:c8:f9:16:6f with an ethertype of 0x88e1.  Some =
quick research suggests that these are HomePlug Management packets =
generated by a "Fritz!" home router.
>=20
>>> commit 06ef8089f876b6dabf56caba31a05c003f03c629 (HEAD)
>>> Author: Simon Glass <sjg@chromium.org>
>>> Date:   Sun Dec 31 08:25:55 2023 -0700
>>>=20
>>>     efi: Correct smbios-table installation
>>>         At present this code allocates memory when writing the =
tables and
>>>     then unnecessarily adds another memory map when installing it.
>>>         Adjust the code to allocate the tables using the normal =
U-Boot
>>>     mechanism. This avoids doing an EFI memory allocation early in
>>>     U-Boot, which may use memory that would be overwritten by a
>>>     'load' command, for example.
>>>         Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
> No idea how that could relate to the packet you're seeing being =
written into random memory locations, sorry.  I'll leave it to one of =
the U-Boot developers to respond.
>=20
> Thanks,
>=20
> Michael
>=20

Whoa! Good eyes, Michael!

What is my Fritzbox doing to my initrd, and why does reverting the =
commit fix it?

FWIW, I also have a capture with an ethernet frame from another device =
on my network (ARP, ethertype 0x0806), so this is probably the content =
of some ethernet receive buffer...

