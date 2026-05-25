Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF9CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 20:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BCE084946;
	Mon, 25 May 2026 22:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=izzo.pro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=izzo.pro header.i=@izzo.pro header.b="hWg58zcR";
	dkim=pass (2048-bit key; unprotected) header.d=izzo.pro header.i=@izzo.pro header.b="bYXVXem2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26DFD848E2; Mon, 25 May 2026 21:41:04 +0200 (CEST)
Received: from outbound.soverin.net (outbound.soverin.net
 [IPv6:2a10:de80:1:4091:b9e9:2212:0:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9773C847C8
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 21:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=izzo.pro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=federico@izzo.pro
Received: from smtp.soverin.net (unknown [10.10.4.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by outbound.soverin.net (Postfix) with ESMTPS id 4gPR7x1S0lz18NR;
 Mon, 25 May 2026 19:41:01 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by
 soverin.net (Postfix) with ESMTPSA id 4gPR7w4JTszJT; 
 Mon, 25 May 2026 19:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=izzo.pro; s=soverin;
 t=1779738061; bh=TM0sunBK/YcB7tsswrJESfIxhTvTaIOIaD7xkFWz3d4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hWg58zcR+4p+33eNV+/Im3NI4yx+aNUEctCKkx9o+rjkYZvQK4F3zi4ZK4+2sBW8R
 0LgykgYVAZ7YZVaC2AepVHCOGyJPgQiVekfES4DHz9GlEysJ1fsbmIfpKRcNtbjgi1
 KgaG9l9JYLNc3a4zo6RrU/95+xoddN6SUDxxWb49MnNLHmL2Jd7jbmfVBznstTFDM5
 72Y9OLJfa8af3yt8UdAyFXDzy3gHjrMUokNA/UcNjZ1DZWuJRJF2Vf8wj/hXNiFxYg
 H1ymgbKfflZ3tWGKXG9vgotFBnNZtt1kps+k6xZbYw8La0UTya2m192eWo8ETrc+vQ
 z1Qj9SPzuWKxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=izzo.pro; s=soverin1; 
 t=1779738061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kVUHYncccUYW8OuKeU3j+TdgoCW612L6kyPBz2sCt4c=;
 b=bYXVXem2hasbWoplpVEc5Csc+i8mMiSKloBdr9H16NusLvBx7Vdbbgd5l6IGjHirYI6W7r
 3jdbQW1DjDYV7Ozk6dkeXrVaUJU7ChSv8e83BGRz0py7uHDCOiPciLD2s/cEPvgm0g2pGb
 g+tp01aAUJY+xXFUTIqDoNyGkYbDqiZJqIb6aRIxqgP/4bAwMmn5yiJTpvEucRQM0eAUt7
 ZBHpMF4J9pj6ojAw8nFVEVt57uPGBWOVtQAvj7FefnPAM6OWMOtQPEnjgk6aY2/eCphq9O
 bsS+/sNs+/ihB96d5mB3mBjAdNvIyQ0AuDsqa8uoPWUj1vNK3pitkPip22zWCQ==
X-CM-Envelope: MS4xfGD7TYVgFCwYP20ISpMA594e95xS7VBU6yrM3wYCXJ41e7dCXSHbkhqytwRucAdZsNLAN794ZH0MUPn74vnluIImASq/gzj9o3unVA9+NnJgz55JrAkX
 WLLkWE2vxz9ZQKANw2bvueZMbsoYuwr21mTDrnSQz9ID83YukZz9Vl3HTFiMfBeaK5oDWwZ+tNAhEC6GpnwFG3PNU4VZSbbyXAs5ALJEQFL7uHzKAqWeotpJ
 JGYEKdfNtj7iDKsSCNtVBAPAaf4EeM8afmHS/D5NCmJ4PtL7MbdIR3lAC/WQcuv1isohA+VLxHQTGN3ILh/hXHrKgTTS7JaeP/IqvB8yOSDZWZN+vzCg119K
 3GgY44dNni6FZoMJYOlNHIeRrQDYCNuoK3PDm4q1XlcGYcrrNtws6qRji2ij82+gYXEriyOF0NVuIvzuVbghx//F5nFQCwgBQIY7ho8VNKWjRmcdyun5YMET
 Wso5d9+DzwxLpr3HB4EAEzIPfjzmDzjnOinpo2n8F8ngkm9y6ifZYsmg2DHARyAwBvMf2yI6lDDnN9UJhahshJ64Bc4/5EtMErVNXdu2okJFWHoD6Sjgayj8
 fSm/NgZz0RmRf/Gd7aAOaCJXDwmVfRKZtdyNmXhAywQDoA==
X-Soverin-Id: 019e60a7-a8c8-768e-b237-ca046a198d59
MIME-Version: 1.0
Date: Mon, 25 May 2026 21:41:00 +0200
From: Federico Amedeo Izzo <federico@izzo.pro>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, Bhupesh
 Sharma <bhupesh.linux@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Julien Stephan <jstephan@baylibre.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Luca
 Weiss <luca.weiss@fairphone.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/2] ufs: qcom: add ufs host regulator support
In-Reply-To: <177971117506.986002.14811075924990554544.b4-review@b4>
References: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
 <20260523-qcom-ufs-regulator-support-v4-2-45639533b06d@izzo.pro>
 <177971117506.986002.14811075924990554544.b4-review@b4>
Message-ID: <4864d2a49cdabe9b52e297cff11d7f4f@izzo.pro>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham
X-Mailman-Approved-At: Mon, 25 May 2026 22:20:05 +0200
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

Il 2026-05-25 14:12 Neha Malcom Francis ha scritto:

> On Sat, 23 May 2026 15:04:25 +0200, Federico Amedeo Izzo 
> <federico@izzo.pro> wrote:
> 
>> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
>> index dc40ee62daf..0e2e45f1075 100644
>> --- a/drivers/ufs/ufs-qcom.c
>> +++ b/drivers/ufs/ufs-qcom.c
>> @@ -561,6 +562,19 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>> 
>> priv->hba = hba;
>> 
>> +    /* enable regulators */
>> +    err = regulator_set_enable(priv->vcc, true);
>> +    if (err && err != -ENOSYS)
>> +        dev_warn(hba->dev, "failed to enable regulator 
>> vcc-supply:%d\n", err);
>> +
>> +    err = regulator_set_enable(priv->vccq, true);
>> +    if (err && err != -ENOSYS)
>> +        dev_warn(hba->dev, "failed to enable regulator 
>> vccq-supply:%d\n", err);
>> +
>> +    err = regulator_set_enable(priv->vccq2, true);
>> +    if (err && err != -ENOSYS)
>> +        dev_warn(hba->dev, "failed to enable regulator 
>> vccq2-supply:%d\n", err);
> 
> vccq2 is optional right? Is it verified that the optional code route 
> will never
> return ENOSYS and there is handling in regulator_set_enable for NULL 
> regulators?

Hi,
vccq2 is indeed optional, if it's not present, regulator_set_enable() 
will handle the NULL regulator and return -ENOSYS.
The warning is skipped for -ENOSYS as we don't want to print warnings 
for non existing regulators,

Below is a section of regulator_set_enable() from regulator_uclass.c

int regulator_set_enable(struct udevice *dev, bool enable)
{
         const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
         struct dm_regulator_uclass_plat *uc_pdata;
         int ret, old_enable = 0;

         if (!ops || !ops->set_enable)
                 return -ENOSYS;
[...]

Greetings,
Federico Amedeo Izzo
