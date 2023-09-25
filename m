Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A66E7E632
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 13:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F4B86D36;
	Tue, 26 Sep 2023 15:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="ZCpweCvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48BF586BF7; Mon, 25 Sep 2023 21:08:04 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4968F86A24
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 21:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-503397ee920so11341186e87.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1695668881; x=1696273681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5oKTu1GeOl/MTZPcWA+Bgi8EfImx00QPgDf9jkFpTk=;
 b=ZCpweCvdCkCT40JE+//xLtdNE0zxEXPfZtQ2+Rnc3ObqWIz6AUVzPdlL8tdx2tsroa
 zsjR8LmT+0o3tanhr/M5C08ufMoGu/Qhe4b5UrPLET0VmQZ7TWJadQouy5eyawp6Q1d9
 YUn0HCawOf4Iy5aFKdaiFxjKGvkEYgbPCsGWyawV/UDtE4u0z/CqSEHw/XEYmTR7302c
 ztdsfHVzh6asXt71NhBE9yFDwS0//OWvJY7lKcFcTEo0Ajzpi99HxzDV8pw9hORANmVC
 TStsCPiehzSv9rThsXyUjO87ooCFn492/mi+y3Y8pHJUmb8xouW/HPWa79RliffFYVmv
 UKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695668881; x=1696273681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5oKTu1GeOl/MTZPcWA+Bgi8EfImx00QPgDf9jkFpTk=;
 b=JmOM2phcPkyPaP/r9V0F874hZRAbZ/BCr9sQ8QUDjiJvSx10ark+A2Nb9fHDCm4tU/
 +/7bi6RbI+JpZkF/KFBsLfS7vOdZL+qqjUCUXu0CHk0kgSLxJq9E0npnPDEC1MsOxZxz
 gf6Y7knraXGf87Uf0creKYhlw8swMRc6rFx/Xl/YFWv3ADt7eYam+ahuwhIx0v7pva58
 2GMN5UNgzdLUfJ64C1vCo5rpb1ZKznTF1vby8BX2Vp0MSAVygHkwrIOtp2ezVLzXsgHI
 aUS30kGii668Lhst24Vx/ozD87hJiA0pacVmTo1ctfgo1KHGH7NQilo07I1J/lhoqsAh
 Ie+A==
X-Gm-Message-State: AOJu0YwLQd5p8pRZdxLvl2mxcTN5GR4FQSXbjbwzyg3Z7VS3qshwg7Wy
 lvsHij97Sf5xKoIVZ8CRve/14Q==
X-Google-Smtp-Source: AGHT+IHw10pRCFuIgDX4bDWeRy6NBEi0G7vResxqXJ4FGChk+Trzpc0c/zuqKI5wvopkNMKrrByN4Q==
X-Received: by 2002:a05:6512:12c4:b0:503:60e:91f5 with SMTP id
 p4-20020a05651212c400b00503060e91f5mr8141522lfg.36.1695668881103; 
 Mon, 25 Sep 2023 12:08:01 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 v2-20020a056512096200b005030c533843sm1924568lft.154.2023.09.25.12.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 12:08:00 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: sjg@google.com
Cc: artur@conclusive.pl, eugen.hristev@collabora.com, jakub@conclusive.pl,
 marcin@conclusive.pl, u-boot@lists.denx.de, wojciech@conclusive.pl
Subject: Re: [PATCH 1/2] common: add prototype for populate_serial_number()
Date: Mon, 25 Sep 2023 21:07:38 +0200
Message-ID: <20230925190738.84460-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <CAPnjgZ0QSYEAy4auM-COVF0B5Ls5E+8QL3_kYXbAJrm4RYWDpQ@mail.gmail.com>
References: <CAPnjgZ0QSYEAy4auM-COVF0B5Ls5E+8QL3_kYXbAJrm4RYWDpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 Sep 2023 15:07:17 +0200
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

Hi Simon,

thanks for the review.
>Hi Artur,
>
>On Thu, 21 Sept 2023 at 09:44, Artur Rojek <artur@conclusive.pl> wrote:
>>
>> Provide function prototype for populate_serial_number().
>> This is useful for boards that wish to read their serial number from
>> EEPROM at init.
>>
>> Signed-off-by: Artur Rojek <artur@conclusive.pl>
>> ---
>>  include/init.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/init.h b/include/init.h
>> index 3bf30476a2e0..e0b7fbc943ad 100644
>> --- a/include/init.h
>> +++ b/include/init.h
>> @@ -283,6 +283,7 @@ void board_init_r(struct global_data *id, ulong dest_addr)
>>  int cpu_init_r(void);
>>  int last_stage_init(void);
>>  int mac_read_from_eeprom(void);
>> +int populate_serial_number(int devnum);
>
>Please can you add a comment for this function? You can move it from the C file.
>
>I also suggest renaming it to something like eeprom_get_serial() or
>something like that.
I'll go with eeprom_read_serial(), as the one you suggested is
apparently already taken by board/gateworks/venice/eeprom.c.
>
>>  int set_cpu_clk_info(void);
>>  int update_flash_size(int flash_size);
>>  int arch_early_init_r(void);
>> --
>> 2.42.0
>>
>
>BTW tlv_eeprom.c should really be converted to driver model.
It should, but maybe at some other opportunity :)

Cheers,
Artur
>
>Regards,
>Simon
