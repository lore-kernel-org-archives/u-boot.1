Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7B6CAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 22:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D86802C1;
	Fri, 26 Sep 2025 00:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kxyk3d0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BFA782998; Fri, 26 Sep 2025 00:50:12 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B178380107
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 00:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-816ac9f9507so258502585a.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758840608; x=1759445408; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Vd8q5g5XQnQ3krza/lfpSkaAt1ByeWKO9D8d+aH5yo=;
 b=Kxyk3d0UQycc1NBLbLZiQCPqiSzklDP9h4hTRNSgTrNG9IIfV7fjXU3KXJsauezVf/
 aXMsseFZcX6wZoWcC7zTFM+i98hwC2MN1qY9X/nPt+miCezQ32YfUc45K5ZV6yD/qzGO
 WXX6i+SC31rXg9ai+T9soN3iqwb+QyFC+36u94agV+BRN2TS22lgizg1DwGOSscHJyRt
 Q1eCd/S5QsXSNBeaNFWjDVb7EXioqJ/U+8p3AcgxhYbTBl2yo8clNWMVXJPS+7yOq79G
 IpUVLCW25g4XT1UbwUkHJSyLxLpQ8x9WwA75km7vcyeSVL0xhf00oxgslIlS8DpEhB0U
 fwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758840608; x=1759445408;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6Vd8q5g5XQnQ3krza/lfpSkaAt1ByeWKO9D8d+aH5yo=;
 b=Qe7DY1I5hpo5aR4XNp4tVrqgZ5NW6Fm/LBTn7fvbVQtTMYjxZPiG2Aul8+OjMVwlui
 zGUGSGNZU1ClJHM/S+frycmtqH63pXVD2gz9tvpBjoHwbyR5ij1Jj1Sf7siotYCYnquS
 H5j8P1sI2XeXymrtiNWuMLYO1XOp950K8rpSpw+Y4sEhFbNxf81lRrmeF2j000EhLaFs
 gdcLWOLhye84h1xB06vh2PRMFnszHEqLbpTaCm50ExApPj2uocKJ+DF6dY/MEz1o2gNS
 Xzqz2iL9zMJC3F3zWBf0sbWlkneRFskEIrPIg7kyLXt9v+sYY2ejTvQdCHlhhkdhd7tj
 wXVQ==
X-Gm-Message-State: AOJu0YwQKybx2K8v7A+dAZNS+rc1cwF0hr6y2ub+xNxnbjgWXbY8Ux6r
 knEiJCLm7v5rei52TpxNrfD4EiW5Oiy7aXyFyE4OTXDoQ9AT2f+NnY/5iCdWPeI31bU=
X-Gm-Gg: ASbGncu6qCdjo9Qvf3hp/KpczDd8bxAljapb0A/Yeo4n0ES0yfBuOBgMznLMZC+v1P7
 I4g5lxBBnX7Z0kF6zjuFSECy3IKVW/cD2SMmngU7tlq9Dco3j4TQckEWJmv/W9hd3+/jgkOb5Dm
 zFKBcXQc5slkE+wtxOt3r5tVy+YFIsCb5xs7pgIDxuFh5byH7WUivhDDzjkrzEk5bdSGADc/06O
 ga8QovPreAZlLYrdAI2h/iEFw/CwZ9SSAALOusSVbXSki6zULcvrqcL7sgwyqPYb/1ZGkv4hg2P
 E4aO7335HLqfwbJuSaMl8kLnDpSg31vx1ujg3rUV3wOfAlDiU7k1lb0+D+5d9y7jGEYqD60o9z5
 Xi1zTprOQ1afU6gPfFGWIR0vat8mNJJjJWSoUCMQr4+7WP5sjqFSjLqaWbLHDjeIlJiLpmj4YoD
 ZAIacQlVQx3oR/ag==
X-Google-Smtp-Source: AGHT+IEqnsmsuNZ1BBRdPv/TrEIbZW4h7idyMaoczpDj2EIARhUt/bwuncMVuOsKxz6cO6/RgbRsWQ==
X-Received: by 2002:a05:620a:4507:b0:801:537e:cddc with SMTP id
 af79cd13be357-85bc3049cf5mr522766485a.13.1758840608488; 
 Thu, 25 Sep 2025 15:50:08 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4dd88fdc0c8sm1075981cf.46.2025.09.25.15.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 15:50:08 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id 7D8B1F40066;
 Thu, 25 Sep 2025 18:50:07 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 18:50:07 -0400
X-ME-Sender: <xms:H8fVaHfhoNX7yiiCS4EY9S5L1hO2Mezinb29oYxQLRDANaTNsouVNw>
 <xme:H8fVaIC9U2f1qlWdNg06NeUuRYOugfCNCeLOukBpEsHzqwmigbKBCh7_xMWreIvml
 cdmvlc3FsHD8K6ZckNYZvsLqM6LhyqsaQfk98rSosaqAJsfxvuXxg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeejfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflrghvihgv
 rhcuvfhirgdfuceojhgrvhhivghrrdhtihgrsehlihhnrghrohdrohhrgheqnecuggftrf
 grthhtvghrnheptefhleffffetvdegueehgfefgfettdeivdduudefueffgedukeefieei
 ffeihfetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfrghsthhmrghilhdomhgvshhmthhp
 rghuthhhphgvrhhsohhnrghlihhthidqudehvdekkeelheekfedqfedufeeigedvleeiqd
 hjrghvihgvrhdrthhirgeppehlihhnrghrohdrohhrghesjhgvthhmrdhmvgdpnhgspghr
 tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhrihhniheskh
 honhhsuhhlkhhordgtohhmpdhrtghpthhtohepihhlihgrshdrrghprghlohguihhmrghs
 sehlihhnrghrohdrohhrghdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnh
 igrdguvg
X-ME-Proxy: <xmx:H8fVaNZIBhq_b7c37O-oBlyaTy3b32UGvsxQeMyw_HOAqibh6cV2yg>
 <xmx:H8fVaMLKL1xtbUOLX6LYCRd1_rTmLF_Y4MK242Z1dzY9D3uGaFWuUA>
 <xmx:H8fVaDAcvcHFhaMb9mT5HW7rsHzOZvZbcLEEYCYgUNyik4SyOPukjg>
 <xmx:H8fVaJqhqQu_FLC8mZyML2Q27iuo4S9asu8vPlXBXQhTbIPg-E3Q_Q>
 <xmx:H8fVaGg0NVLe53meivT2VD4-nJ1FmoK-W-mQPtmqAOwMP-Q4mNgOTZ7g>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 4CEE61EA0068; Thu, 25 Sep 2025 18:50:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A_MkewDl2oIw
Date: Thu, 25 Sep 2025 16:49:46 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>
Message-Id: <5895316d-2006-47cd-8dba-891794a38405@app.fastmail.com>
In-Reply-To: <CAC_iWjKBzrJJj1fzeAkBeV2ZrOO1fT+9QUHrVdkb0FFD+seafg@mail.gmail.com>
References: <20250924233120.454116-1-javier.tia@linaro.org>
 <20250924233120.454116-2-javier.tia@linaro.org>
 <CAC_iWjKBzrJJj1fzeAkBeV2ZrOO1fT+9QUHrVdkb0FFD+seafg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] part: Export part_driver_lookup_type for external
 use
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Ilias,

On Thu, Sep 25, 2025, at 12:20 AM, Ilias Apalodimas wrote:
> Hi Javier,
>
> On Thu, 25 Sept 2025 at 02:31, Javier Tia <javier.tia@linaro.org> wrot=
e:
>>
>> Make part_driver_lookup_type non-static so it can be used outside
>> part.c. This allows external callers to determine the appropriate
>> partition driver for a block device, enabling more flexible handling =
of
>> partition types.
>>
>> Add a prototype and kernel-doc comment in part.h to document the
>> function contract. Provide a stub inline implementation returning NULL
>> when partition support is disabled, ensuring build consistency across
>> configurations.
>>
>> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>> ---
>>  disk/part.c    |  2 +-
>>  include/part.h | 21 +++++++++++++++++++++
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/disk/part.c b/disk/part.c
>> index 66e2b3a7219..f0c6866e210 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int=
 part_type)
>>   * @dev_desc: Device descriptor
>>   * Return: Driver found, or NULL if none
>>   */
>> -static struct part_driver *part_driver_lookup_type(struct blk_desc *=
desc)
>> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
>>  {
>>         struct part_driver *drv =3D
>>                 ll_entry_start(struct part_driver, part_driver);
>> diff --git a/include/part.h b/include/part.h
>> index b772fb34c8a..52fd3d534e0 100644
>> --- a/include/part.h
>> +++ b/include/part.h
>> @@ -471,6 +471,9 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_=
t start, lbaint_t blkcnt);
>>  #define part_get_info_ptr(x)   x
>>  #endif
>>
>> +static inline struct part_driver *part_driver_lookup_type(struct blk=
_desc *desc)
>> +{ return NULL; }
>
> This won't compile. You need to define it in the #else of #if
> CONFIG_IS_ENABLED(PARTITIONS)

Thanks. I have fixed it and tested it in the CI: https://github.com/u-bo=
ot/u-boot/pull/816.

> Cheers
> /Ilias
>> +
>>  /**
>>   * struct part_driver - partition driver
>>   */
>> @@ -727,6 +730,24 @@ int part_get_type_by_name(const char *name);
>>   */
>>  int part_get_bootable(struct blk_desc *desc);
>>
>> +/**
>> + * part_driver_lookup_type() - Look up the partition driver for a bl=
k device
>> + *
>> + * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each partit=
ion driver
>> + * against the blk device to see if there is a valid partition table=
 acceptable
>> + * to that driver.
>> + *
>> + * If @desc->part_type is already set, it just returns the driver fo=
r that
>> + * type, without testing if the driver can find a valid partition on=
 the
>> + * descriptor.
>> + *
>> + * On success it updates @desc->part_type if set to PART_TYPE_UNKNOW=
N on entry
>> + *
>> + * @desc: Device descriptor
>> + * Return: Driver found, or NULL if none
>> + */
>> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
>> +
>>  #else
>>  static inline int part_driver_get_count(void)
>>  { return 0; }
>> --
>> 2.51.0
>>

--=20
=C2=BB Javier Tia =E2=9C=8D
