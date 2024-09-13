Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57176FA3757
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 13:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1DE88D89;
	Fri, 13 Sep 2024 15:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="m6C1FnG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 593F188D8D; Fri, 13 Sep 2024 15:50:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D18088A5F
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 15:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726235415; x=1726840215; i=xypron.glpk@gmx.de;
 bh=KWN3l1Q8IuN1V14ZIecyOwpmBNKQnm9Ri57GMBCUrsI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=m6C1FnG4Uz79MJCI106mdZ4ytAtgGBMM4CMEzn9kB7AAME8d2trKnqNcRaeNlcfl
 gARI1qy8KVMpVYusPJyyH27nRaTUOFb1kzObEYfng6MPCuMpoI6pZ6GGj9dzQOrUC
 4MD7USR74ytVKqKu9Q2IfM4KmmcPPoJGM2O6SVtpAoZRaUkqkAdxla0G5Omk2aGsL
 WhRLQ3jwQ93biDZGHkibcNwZ1A+RwctDcmUR5EAY1w4NOJdDWToTLClD5J7F3sOt1
 /FgJS8x5XTy83aEQcVti+DYgCVaYNiy45Bi0rQggN3JSLeldv9Bn38hGq3r/hemaO
 allVijsFRJSX95Ug8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QS8-1stWX11jQO-004UvO; Fri, 13
 Sep 2024 15:50:15 +0200
Message-ID: <eb5c045c-194a-4c0c-8617-4833e174db8c@gmx.de>
Date: Fri, 13 Sep 2024 15:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] efi: Add a test for EFI bootmeth
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240902011825.746421-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EUXJ0nLQGOB2aIOZTqIQ7QsbAUUjTYVxNrukP8MvAW1bG8wXIvs
 HtZyU8pDMC/NzhyYyZGHjmTzgK5s6n0Ax7Q7BWtXkl9KkR8T2OtZ5pL0AgImSwRJzy9LUF2
 WSW7vExdu9+gvAyCesQN2C7hZPZX9DYm7CvJtRv5L+UPWyMOHHsZjyVImwCkQM7kdevBglJ
 ZpAozb7vYUi3TeOCefOZw==
UI-OutboundReport: notjunk:1;M01:P0:r44Er9MpqZs=;75BaJNGTPRV35nGPcz1AIZhY5U6
 fG/TEQe/2paeT4OgThf9PUTjcKlkZHqMFgHuwv23Jp9xZoiEslw9w4jkgu/sPlWzDcGAfNABm
 uaQIgEUD+Bwdn5E3qepVAAq8X7czuvtGRVmKIyF3v/XL7m9/gQ+9LIAxEP0HsE6UD6rpUfCP/
 6ljSP/np4KZMNolEmIliub4As1BrGnw2sgYxRbNbRV/fLFoFq34CbNC40Lju8kbH2XIs7z06I
 1vltiz8M1x4TC33C/ZgFXkq/JhvEul+HA1Ont9wgKOz56JgyT09AuPE7sjUcm1X0dqmBESOLk
 nZcp0jXEDSr8IFnB5we+9hvuBxPyT9YYdSpmCyTJtoyQR/NEE7KNVC6kSmAcov/pazg29pDl5
 P69ghtFkle1S2vkHL/tD734LqKaFXuPhz0Nr/fOViZ29S8gEip0cv/01AOyqwfFH0rfFgbAZr
 k2X7FqytykpLkddrZ/DEFVZcoC4aRBvPWwWXMNr9YofrsMgcUMlpKEsTfGZPDrCRSmdDdmZdc
 SWODsKYUBngEnTlUn4AgPkHrdYw0lRBcQlaOPnAYXCCQN8Kw/Q54MVrMFKE4f0+fP+V5h9OFG
 dwC7rWCv9xSSaePDsRoeEifQiYAeGcJhQ05NrBFS8/5HkX2/Vkxh4AAT9cXY1RTyC8ihOC6br
 eUxqgw2gtnULLFK8lLKOP7KlQVRYG/VD0Gzdy0+OQu9uWkF1kqg+j0UzoePN/irJpn6AzPQt1
 +Qa5pvEmsrAiBxFzUuxnyvNRnLuoloTRazSAPpVQmwxKHRm+kH2L4HN09j5kIskyWCjQvbpoO
 6oP9PHrwZT4mB4d/q3qLq1PQ==
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

On 02.09.24 03:18, Simon Glass wrote:
> The test coverage for the EFI bootmeth is incomplete since it does not
> actually boot the application.
>
> This series creates a simple test for this purpose. It includes a few
> patches to make this work:
>
> - ANSI output from the EFI loader confusing the unit-testing checker
> - Hang in sandbox virtio due to EFI probing all block devices
>
> Other necessary fixes have been split out into two other series.

Hello Simon,

Patches 1 and 2 are in my pull-request for the next branch.

The rest needs to be rebased after considering the review comments.

Best regards

Heinrich
