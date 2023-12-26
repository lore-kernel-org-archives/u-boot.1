Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B08C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C07878B8;
	Tue, 26 Dec 2023 10:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TZwrYxts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A57F08786A; Tue, 26 Dec 2023 10:53:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD0B87835
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703584430; x=1704189230; i=xypron.glpk@gmx.de;
 bh=i4ZkGCM7ZRzPNgDCbJHes5GMfG9Sf3f9E5zjs9pBLMs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=TZwrYxtsj9dpO7MVX3Q6O4ZW/ueQFua7ljZH2DOD1dHFmZy2JqPXisofI03DGZY7
 dfCPY4BJ5s1OfvZF6iC2jI87Ec/KiP1BbeGGYblhn/ZLx7BYNqWWVG70HNjk5tnEs
 54+qK+nayOWr9BS9uN5/UafyLgNJ4BW0HiHqDQAAyEk1w7JxhlR3284I9Hwp24fuj
 gu7k+4TMKd7TJ08VADj1oSzolLqbmsLPQFpC6c1nwt+MAj2OkUJ2bBUa30hGJAXtu
 GjyUDtJeILN1+1be8vOVtez6/YVbV1E9dnUtZGpoP/Vvc9hG7DLLEHfIKJh08p/4s
 ZYGngGcpd0SKW+kMEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1rI48E354C-0000jW; Tue, 26
 Dec 2023 10:53:50 +0100
Message-ID: <a838f7a0-d966-426c-b4bf-3d712b871de5@gmx.de>
Date: Tue, 26 Dec 2023 10:53:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] smbios: type2: contained object handles
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-3-xypron.glpk@gmx.de>
 <CAFLszTh5Vu9g5Z=ty17e1V-f-zLsKXnkP2wYAMYHfLKbCahG3A@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTh5Vu9g5Z=ty17e1V-f-zLsKXnkP2wYAMYHfLKbCahG3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:015JHP1541NVVx/DRAvHYhEE5ExKpmOFSByIr4MxrXbrc1Hm2/u
 oU2UtgCWLrub5tofoTRDETeZjNJWBp+oM9ONxs2h9tfbxB+s7lSQ8ISorY2WoYKFbjRzGk8
 HGRyecmSWAvxt3HyR3UCGLwlniCK5z4zyVUP25J8GskMC7pr1s/yobv4H2Z6bSSkYU3os4h
 ByT6cK5pnr0UNA16F4yEw==
UI-OutboundReport: notjunk:1;M01:P0:z8sWb5GcGPM=;4MKZNkqChSzNvReqRizO388FGm6
 IX5jK1BF6uGaTrGrQcTB1BuVPrbU5l2/Ons14+C6NaryBOdbuu4WxW5cNK7ktve1h+J0u+fyo
 6ZM158jZV+wwWGPzHcSw+JCdomhCNF9VGSFGqTPrgYEl1JK9fR9xi348DSEGJlHMmcK0xN043
 0w7U35SxJ8XbNWtFy4nxqpRAZA5PcTRhaUwUweGs0Jf/fa9ROqGBauIMJ8j7kCU+MC9ueP2EY
 YZOISMSIuTXXi5hnxqOUzR1CNzoPrAk3liikpt0aXdKmB4ay8aVCM2jgt400cfbCGffpYtbQM
 kWhqsR4r9U3gGXoLdU/ow0qIkvHyidCqXifeJm08Ux7UP62oL7YMTi9mJebjbnWree/CjWNLr
 pAsGIgTVjo2NSB03pfLsQKH2WnmRttBMaPgbylKJksxKuAM5M36CpY/BEdAyIp1R8kPZ848Fw
 RJvnqiu+OT7C4xbkodpUXq2XQavmwkmQfVvH7LRVrvPBW5DxtFq1/+AjFki/org2Mowib2K0B
 RIHbvyZFAQY2DOxlX9nywzJeb4NlQw8zKZEe587lyPLS7nN274unfThuUokiPtoMf7F+t7yND
 AottfCnbXdi/1oKoC6b1s8X16yDudi0DWxrbzTzRgZZbWuzj2EgKyQhFUJk7zFPhb+P8GwxUj
 E7CxAjWZrzF2smDJxXmKiG4TKY7fZUaNhA/uWCuxUwir7SzZwV0vYOORVVRzMsaVsLQclY/RV
 LvF8aSpZsltNs0pv//CELuAZrej4WC+l2uAgGaCm+xqZ+YFNtP+IL13rOdpa8Qw9Xt5hiYaSj
 9JEtcytrTbDe20Z+w5/2JwaEIPFejLVyYg3vEdCTylptfRSVjkrKbQwpGiiAKLlBXmWXp7/lx
 eVc5mpOhaK0eEOAoyv1LCtTrauawV75T7JiQIX+KV97IcqwUNu8HoM1PsXBqb3/0on/zwfgfj
 a+NcMQ==
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

On 12/26/23 10:50, Simon Glass wrote:
> Hi Heinrich,
>
> On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
>>
>> The type 2 structure must include information about the contained objec=
ts.
>> It is fine to set the number of contained object handles to 0.
>>
>> Add the missing field.
>>
>> Fixes: 721e992a8af5 ("x86: Add SMBIOS table support")
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>   include/smbios.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/smbios.h b/include/smbios.h
>> index e601283d29..88c19ae062 100644
>> --- a/include/smbios.h
>> +++ b/include/smbios.h
>> @@ -139,6 +139,7 @@ struct __packed smbios_type2 {
>>          u8 chassis_location;
>>          u16 chassis_handle;
>>          u8 board_type;
>> +       u8 number_contained_objects;
>>          char eos[SMBIOS_STRUCT_EOS_BYTES];
>>   };
>>
>> --
>> 2.43.0
>
> I thought I already saw this patch elsewhere, but this one is not a v2?

I should have marked it as re-sent.

Best regards

Heinrich
