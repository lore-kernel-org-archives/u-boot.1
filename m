Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D44C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AF79809A5;
	Fri, 28 Feb 2025 11:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tE6Pq2et";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B24580BA4; Fri, 28 Feb 2025 11:53:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12656807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740740013; x=1741344813; i=xypron.glpk@gmx.de;
 bh=aJpsvxTjp49NoL7iirB6BcS+Isu7Yj09Qtr/OF8a2Mc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tE6Pq2ettCkG8wYBB3BWa0phanE6zO4zJCaFDs/NJZJ4Lq+nbOQRxQRHndufJ/1/
 grZI9b1RHcUkJ0/c0CzQA3MneYODYhnNpW24D8/dFacYVtemVplTd/ySbpzN3i11F
 sT/pXOUs5g41WJ22wPO/c35zPV/t+pzuGM/UQf6gIVegim0VeAxsS2sFehbm3+Vd1
 cvqEI2B+kTIuRollNiceXNTKDUPsfmYWSGhV+IVl6XEU9246f5CwACzlS8z3InYm7
 hbzEJhf4bYRfjlsM4z02lCpuhEllbF5tSfIDOfxhVfulIo4LKQvodKCLQKs+GPdlU
 zf5n89PRCtUwDtwstA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1tqzjM1TuH-001wUu; Fri, 28
 Feb 2025 11:53:33 +0100
Message-ID: <43dc4f73-0eff-41bc-a963-f67189f02dc2@gmx.de>
Date: Fri, 28 Feb 2025 11:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re-installation of device-tree as EFI configuration table
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <CADg8p97dZNnizzt7Z-3_=_1bgJV0mJAd+HmK+BFmZ7rhmdx+uQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADg8p97dZNnizzt7Z-3_=_1bgJV0mJAd+HmK+BFmZ7rhmdx+uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KnwhMAsWH7LRRcGKuoz3q8ogQdzxFimyU8LoMSed1JPyNurqi31
 UYmXZYFugfiKVLtsVX2WAdVKZgMgQGAil5oW63dH7qgzSAkpOyGLWLGZ2zGyjpNSeHVwDNh
 gesqs3F3a73CPbS32jVqzk/zRd5s1AVZr8z0FylUlKMrQ02L60veK+o3S1ibr0mOPlQ6/mW
 ATaXcUF+ME+q/0iotRERg==
UI-OutboundReport: notjunk:1;M01:P0:e3GDy3r/Yd4=;iEnN/lz6ayKEFqYRKuTmAFfe+8c
 6lN1soDm/qFX83uio7cesmdQKg8Z66I5/6h7tQpethVDh6salqjDm4tFp56oAfkqwSAaV2862
 p/5M9Ld5WMGuiRLVWaBCyrp/4b7T1ci97tcyvpP+o4PZoPYgikLnIILFOoDva776rq9sfcQxg
 B4UVe0Vv4xh7ntWSn68AfMTb9HQ9/Cu2KzhSsJmLtT1DHZFNJ0sNdPQSkhA/pkjQLrKXVojES
 iuM2rneHK8iQ0kFubonyiBYsXnIFU87yFo1sOi45Rx0BZEupsmL9Aw8uQGJp9Y9lsDpQryrhI
 i0KocLl8VwmITsD2VlrxQbchYBCumV16cxI1kc1J1pM9MnO89Z4wkPerpovinJXO16rNWEaL9
 UTxurll5OiTnfTu3qDvBICpjFE/4Hi42lXrCaySYSF4uzqie+/6G85iCm2FN3NV/vfzEqT5/l
 sAby+cb1YCheL1u9PJyJQM7VgjFNe2gFnCxAmVnAXY2XwjHsdiD2HNu9LblHFvAK/d4zO41w1
 lH+UxyNK9oKa43/AWMndgiikR5bOg00MsOrvVBzuLd4CJ9vh7iXQyPka7CVYZG7YK0c04BXwk
 frHmOzlddEjoa6guecPFiSc8nZj1Q/KUP2UmMQT0NIOWzWQlEE9WGlxWlF6q1Pu4qyGN9TdC6
 ucHsrXRRboxQMB+slVaaya7uVYlMCHS4BaEiu1Pb5La3e07+3eXhn/PEZTU/0GlJp75YOuA52
 7P8sMqhnTat14oD5PcYfCSpqU9+oDIgj4eXGaXx+8X1pD8EKAexX29k5Dd+F47EkQ9dCRKFZf
 OehQj67c0VW2lscWk8ZUfgBkPQ5VZcYY4jBdb+OFwRdymqVZIx0syTJZVwIk6Oqoo1uoJDFUP
 83pRKaa/Djp+BVhf7iWHjMvuLIGnimOkKWWSSSSeVRK0xjFYdl+WEIBPL3xIA73L92rRrTJgS
 Z0SXYIwjHapi/r4ZRPhRkjBDl8XYPnwEmzyviqWLbe82BlEB5G+P6UhYLQOegO3/2B6FO4Yv8
 gunE+HIXoNNh9R1kwtC25p2gO9UUgHKBiRvSt5MwTXcBodogyzbeOW/QTM3WGVW3XwXGeButq
 QCElvLpASQu9UXnG/9GXflG7Eb9lwhy5aZxt2NdSeKYfX+zPMmm047vzdaz8MkLnA6CqzJzTf
 6Jk3s3fS/hChPlXXpas4IaW6uIjszwoyueW+QoEh8XDXXL0sXXgicqK3IgTHEVFhU9EI2y/N8
 XOFJVy/xJCBkV91Bj+HXfoXsiu1Cs1/4L6pF+k2f9h2TOjWa5nis9cnrm0FHgVgUSNgawHBd/
 OIsyWi8JsGvkuU1eR5rc1+bbWtLFPVL+/Zis3Ws4m5Ee4eNly2cLoJ35JvaMVW96WPQT2QBt6
 gqoFsSwA0qJi5Y/sA9DpI5h2dcV3RWivMeOkwAa9cIuNBYzEk3tdmA1wHe
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

On 28.02.25 11:34, Sughosh Ganu wrote:
> hi,
> The logic in efi_install_fdt() is such that with the
> EFI_FDT_USE_INTERNAL passed as a parameter to the function, the EFI
> configuration table is first checked to see if a device-tree(DT) has
> already been installed as the configuration table, and in case a table
> is found, the function returns without any other changes. However,
> there might be scenarios where the earlier installed configuration
> table might not be up-to-date, and in need of modification. One such
> scenario is that of adding a pmem node to the DT that is to be passed
> on to the OS. There could thus be a scenario where a DT that is
> installed as a configuration table does not have the pmem node, or it
> might have the wrong/stale values for the pmem node. Should there be
> some logic to indicate that the configuration table needs to be
> re-installed afresh so that these scenarios can be handled. Thoughts?
>
> -sughosh


Hello Sughosh,

The logic dates back to
6182495e101f ("efi_loader: need either ACPI table or device tree")

There are more scenarios where keeping the prior device-tree may be wrong:

We could have a first boot option specifying a device-tree where the EFI
binary returns to U-Boot and a second boot option tried afterwards that
comes without device-tree.

So we should always install a new device-tree.

I wonder if in copy_fdt() we should avoid a memory leak by keeping track
of a prior allocation by copy_fdt() in a static variable.

Do you intend to send a patch?

Best regards

Heinrich
