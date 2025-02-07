Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D394FC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA6380885;
	Fri,  7 Feb 2025 19:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MiVc/tVl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0482780A35; Fri,  7 Feb 2025 19:33:49 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBEA380821
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3E98940128
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738953226;
 bh=cqKc/PaIA0sJUM96oO5ERgCaJBV9HspRMEdS12Btc7k=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=MiVc/tVlHE+qEYE2MInoajp6GYfb1K1BHmSk2Kygv/aSthQTJKmZspMe0pJOYBrnm
 zoSwALdgsW0Jk7WG8/wPkzPSQXDpiu08Cf/VWIyL4hK1riuKBoh1bcJ6nYdCmtji4X
 B3Q79Nirs5EzC2j7GqWcTq1Y4nXkMPLI9PcFtlhWaagL/RJyrQU2iDoWqbfFb+JPUt
 JeUkiRa8SETDFPnx7jDkGN2XlyqN2UrfqNlXETNaekLMYh0AVeZtqB71DdVYI8XwGx
 RjZHosWMPDO1w5MPFTuaD7uw2J4fOn+KhQrda2+nOc+Erz/YGgIGnOfyNSDNLQsxnW
 b1BDHzm+NW+tg==
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2f9ee46968cso4764077a91.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953224; x=1739558024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cqKc/PaIA0sJUM96oO5ERgCaJBV9HspRMEdS12Btc7k=;
 b=BAEGBm6PoVzobXlpsa1J2yarhF+TuxOeynLG5ahPY29Mpu8p/9pOAZpUQPb3MlfGRa
 aA+0aZlcwZSLc/BT9Gs7WQOkvnBa2p5lWAGBznL+kg/lFaSQJ18mAQ4fTSHPvfGuB0Mb
 cKLrl5eGMvNXgMdvu7EHQIIvadI707/YNZ+CQBicVopFl35RhfYRfVpfEqbrbiwxbRJ5
 RIfAniH0YSHIoc9gSRNgWHZeLNqSwQGri81g5b9Rv0FX1qbCH3ycwYjXPLn00L2CM4uZ
 lVn0xvsAS80XawrISqxzHHfRe7dBKFOHWbchy4Py+pbChoPlVnu5YA9OOLxszKPloi67
 /Y2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwYLuNdm4HPj4JxBLlP71BF2eSu9GgvAkt5IBTSYLPvvijty0DIAyyqAmQDyHDhk/AEkr94sY=@lists.denx.de
X-Gm-Message-State: AOJu0YwIUVpe4SBQ0zkraTfEksx1i9XbmrFsP0bDHMDNyOjC1Oq1r6g4
 BsKluCbVRbwf0lrFH/KezJUqe+5DHyj47nawQr6JdHLlZQ8rnO7plh4Hue0WagDDQNZuF48HLcE
 6XWwkzDSRUNd/JCxfnc0laD7ulLYKb2N6wWR4IJJGOnYLAXu4hAEbyh1OXTvPM7BsrdFwg0lXnR
 rd94/jhLzXW916WREAoHgvNHsyV/yKSvDn4DYp2GT5nA==
X-Gm-Gg: ASbGnctJZkgqbS+y2ii6u/K9tNZdbGiuk67ws7S0eJWY2tbV5KrLSyhHb+cVFqsAVpb
 K1ORriMAxJmPmCw4vHNsUXgYNI3Z7lGzNviAEN5D/sIE9X/8Rn/6xasy682P7zzvCj3GMtvZPM8
 QTalWa4e3ztjDB6G4Ee2Q=
X-Received: by 2002:a17:90a:f94e:b0:2f2:a664:df19 with SMTP id
 98e67ed59e1d1-2fa23f436d6mr6702181a91.7.1738953224390; 
 Fri, 07 Feb 2025 10:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF32QmXM+hREeOu+MIJnnQ/FvkX3ccyvEnwQ2MNN27Dm5tk4BfXygOBWXhrz7LmpuHhcUNiNe5To8kbAsVuoeQ=
X-Received: by 2002:a17:90a:f94e:b0:2f2:a664:df19 with SMTP id
 98e67ed59e1d1-2fa23f436d6mr6702107a91.7.1738953223391; Fri, 07 Feb 2025
 10:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-3-heinrich.schuchardt@canonical.com>
 <CANV2PTPnRpSdiK744_yFuDwOVUj4Vha_vQjtd8Zd1toYe_Ujng@mail.gmail.com>
In-Reply-To: <CANV2PTPnRpSdiK744_yFuDwOVUj4Vha_vQjtd8Zd1toYe_Ujng@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Fri, 7 Feb 2025 19:33:31 +0100
X-Gm-Features: AWEUYZn4lAd295LvHHO3s_crQHH4WZH7lBkTQkHij-fdaSWnwii6E7JeDgykiQM
Message-ID: <CAM=mAO=TNkYaCFX-7T-VuLbM7coWpAR==ZnYfJ2zJFHLXT7eiw@mail.gmail.com>
Subject: Re: [PATCH 2/6] riscv: dts: starfive: DeepComputing FML13V01 binman
 config
To: E Shattow <lucent@gmail.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>, 
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, 
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

E Shattow <lucent@gmail.com> schrieb am Fr., 7. Feb. 2025, 19:12:

> Is this use of filename preferable compared to a cherry-pick commit
> of/from dt-rebasing?
>
The upstream device-tree is already meged into U-Boot. The entries for the
new board matches how the other boards are implemented.

I do not understand how cherry picking of patches  might be related to my
patch series. I would not even know if you relate to commits in U-Boot or
in Linux.

Best regards

Heinrich



> On Fri, Feb 7, 2025, 09:22 Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com> wrote:
>
>> Add the DeepComputing Framework motherboard (FML13V01) to the binman
>> include for the starfive_visionfive2_defconfig.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>  arch/riscv/dts/starfive-visionfive2-binman.dtsi | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> index 4cce001e80d..63289405fbb 100644
>> --- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> @@ -16,6 +16,16 @@
>>         itb {
>>                 fit {
>>                         images {
>> +                               fdt-jh7110-deepcomputing-fml13v01 {
>> +                                       description =
>> "jh7110-deepcomputing-fml13v01";
>> +                                       load = <0x40400000>;
>> +                                       compression = "none";
>> +
>> +                                       blob-ext {
>> +                                               filename =
>> "dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dtb";
>> +                                       };
>> +                               };
>> +
>>                                 fdt-jh7110-milkv-mars {
>>                                         description = "jh7110-milkv-mars";
>>                                         load = <0x40400000>;
>> @@ -58,6 +68,13 @@
>>                         };
>>
>>                         configurations {
>> +                               conf-jh7110-deepcomputing-fml13v01 {
>> +                                       description =
>> "jh7110-deepcomputing-fml13v01";
>> +                                       firmware = "opensbi";
>> +                                       loadables = "uboot";
>> +                                       fdt =
>> "fdt-jh7110-deepcomputing-fml13v01";
>> +                               };
>> +
>>                                 conf-jh7110-milkv-mars {
>>                                         description = "jh7110-milkv-mars";
>>                                         firmware = "opensbi";
>> --
>> 2.47.1
>>
>>
