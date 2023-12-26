Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED24C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 10:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640F287846;
	Tue, 26 Dec 2023 11:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RlkzFfDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 738C6878E8; Tue, 26 Dec 2023 11:45:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845648783A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 11:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703587535; x=1704192335; i=xypron.glpk@gmx.de;
 bh=xVoGcUDnsMFNDeXLvOjBjC20YykXv7q6wqNbsDHxG34=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=RlkzFfDdtBf9ESH4PA4ttWzNWjrUAuRUlZ2LPmlKczPGbDnPKWEivr93thCFQwcB
 CuqN+9wsGAWgTPxVhBPneQ5pF6n00kEpHWSfenPwIV7p90N5rGFcrEreEcyuj54ka
 nDdN64n8364f9d/Az6cD0+5bMYoxfAQldXb0pDnm37jTnJAn/Zo9HWpCTyplhkw34
 6rtqUyOLHFK2AG0wxD0/FG6HTcMhs4+V37y6byRdgq/xKjnIfyF+q2lZp2iyCv4ng
 cTKVoNymMr9gnPp0p+yudNxJlznNYMKfn+uzZOOy801rvaJvpu9ZsfZKGO1a1tKsy
 mVmMDKuAdxwt/ue+lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1rL6g42dyB-008c4K; Tue, 26
 Dec 2023 11:45:35 +0100
Message-ID: <443feec7-6933-44dc-b2ff-481e0e52d138@gmx.de>
Date: Tue, 26 Dec 2023 11:45:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] smbios: Move the rest of the SMBIOS2 code
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-3-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231015024511.3995580-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:prwtjs43mYItFOMTQf9tQqr38BKB2Stby7rVbO8pxkAfyAYYKsp
 BQV76MARQcx/iGosUkWL6L3YALOwtdMou1CHC/eAs/XTrkkApArGtIOaPGwruJPnyfmCDJ/
 v7OCqVG63gIEqfXrJ0h9TCKQ5SHxmIdqg1D+/9HoiBObXfJyNYKOluqUJIH6UT+EnCNOrNN
 Q97bpi0A+W6bcn+1clECw==
UI-OutboundReport: notjunk:1;M01:P0:1UDLfTkCFRc=;ADGMNCyX9ILSqLAMZtXuHtaS6b6
 +YkkGpWObvU4I2zjVZsrUkPnefo13z9RqNENltpHLk7hLeFdK3q+o1wGeVaDfPvOqGxOt46SU
 eKEcIoJ97rE4Yf6bljG+VAL67iTmBOlrEmfCOZXZ3CYY3HPxOi3hGqM0/7qL7zkVMWEsKFubN
 Zr54LWtCzG/yKhjgvnO9IuPC7AGN+srdPwjc5Rgkyna4/muXxYgIODj6FZ9GYl3KbHBehTElg
 J/8kNtx8Lc1pvWD7v6ppBxjoOPv+Ea6BFw5KkC8ZvgAgtabzCv0zxos6WUKRFcrBl/qoubYxq
 DvMNPoq0TfEWRLDbfgIS/iW68pBpfubJFsi+12ce3acPovwOcWeFJqYgxyeeu36eNv/xiQmpM
 uE5i26iOaEQNrJYx0Yu6f/pA2TE6zcvN2lLjwd9WI2iN2bI/9kaaN5tw0TJFagsSIPT7qVR/k
 hLvR1r/wGJPTCvs4DZfS3vIdYKvs/oDS6vmfFsPgEz++esX16Y2fuXsxe3rG1yvvsXkmuesri
 ZtmkI7qGk98uXyreZtGNV9QWenYbOgjrVPlZho9DEPlOmJjuVPE2F5BVtsjNWisLR6LxqM59U
 OBr9QWI+tKSm4ic9P+S7gKgCpvMso/vH/h3ZljFlkZdT1tqlEJC39nUuiIO6RRtQ5wZkmIVDi
 woXKRyfgVcsogumDb37AsjomP9hkxOP79Si6QfucEBT4f1LGtaHBL5+7asvWT4hxVPcNQZ7XV
 Dopg2txifHr9J9ONN4KdovvUEVRHlIbRxNvf7cKSPBm+5NDlkbGsqxyUrwu6OvfqM2HiXlW+X
 yFtdx+PJompvdInlHLiwqFmoR7Q5j7WOHzYy78Mun9bf+R3kOvx5isYyWSPYfZpHHfQ80UEUU
 ixRSGGdSEHvXCu2FBBJ+6kI64vZvFSr9Cx4UgIJv+fMm3aU7FKxcSRP2oHcyUNJb/PinMRO+C
 yQnuuKJO5efcki7L1yd6gFZCro8=
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

On 10/15/23 04:45, Simon Glass wrote:
> Move all of this logic into the else clause, since it will not be used
> for SMBIOS3
>
> Signed-off-by: Simon Glass<sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
