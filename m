Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4620AC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 16:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBA08785F;
	Sun, 31 Dec 2023 17:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ij2lczpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176AF87897; Sun, 31 Dec 2023 17:20:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348368785E
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 17:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704039612; x=1704644412; i=xypron.glpk@gmx.de;
 bh=4ziIQQyTIugRbzHlqH9MvOLMWJ8hW0OafOEfNY4llU0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ij2lczpjztRYvDAZV2g7+7FcC9XdqeZqe1VYjvz8PrZrCNasmvTwDpPmTqWiQAeJ
 wgoUP72DRTPVLFDb7pyFXBjkPdRPNA1kH0ZXTkS1FFBde8mPY1SdOO7Ur9RA/2oSb
 RtwjCzN9BZoR5WiBJHVYHpT4oEvAwoBYT9IGoC+5jVeqUJGTBWb/xrf01jFLkIh4L
 DckBImnU+2a1sQitkcOxJ/cQwguCIBl2afQz962y1Lx9aIHA7T0FYPtEm6ghnJzDP
 waRP8D6ngHFaqpZEh5TK9peIKCLS5BZ9yQHptdLKQGLzcKl3if2A5fZtq30BY/dGl
 eFFz7usQc/apEeT1EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1rNYe32ZAd-004EAT; Sun, 31
 Dec 2023 17:20:12 +0100
Message-ID: <29b33ebd-1f13-4233-9142-07ad08da75a8@gmx.de>
Date: Sun, 31 Dec 2023 17:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] acpi: Write pointers to tables instead of
 addresses
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Igor Prusov <ivprusov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-12-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231231152555.464874-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+NSHq3CCjV0jm+T53663luBTx1OZk4VDyST2Mnrv9dUW+q+n1Ei
 rDIVWRBxidf0qa0bzimdSzCXE6Iv5F2uUWB1zX7hz8G5gJyh09I0rZ2xczkarSsPL50LHRD
 4NahNeb/iU8zAlkyAwRgf6pHW05UALk319A0QS+lAfnh1ywrK+l+h/Eha6EZUMIfAovlt+G
 I090ld0zamQrb1TFtz+Ig==
UI-OutboundReport: notjunk:1;M01:P0:4QgX/5Fdzxk=;50ljKF1PS+4cdji7vkjQS1aYsTm
 9MDBiHPb45ttOD9BCAAVJLDHQCgSgrpiXW7qoaFSvJ14RCAo8sWaczsK5xTieCYl/wT8acfUU
 bypq65YYG2Q6NHtYnISD4tiSymh4N+6yrINB2+vVLDqDHPH3pId+eu/r37Ld3H+0+CCMcSSA6
 9UWSU1lKZMfK27278O+0IYZouZ3sKeWWww5I8fc/drbk4hGVc+fUMyP3rnTfTp3j3dQAvcNrF
 uWmLa2O997vBzPNRHeYNu3L4CTjWfdD5FS4+vaVhE3tEsFHvPNqNUzGfWsZJG3LscfbALEFR3
 umaSQ0It1x2QJ8rKjHEBf0GGubfLHCxELVD6bKSLj1R7xrDnPcYDSafyS6j5/xUux2D8dKhXK
 zvL+S6bhYw7vBKJ+GFKmlU6ATmnvcR3cmQV8rv8ziNw8nTVPoyjp9E+TAO24+zRUd01ZTIO2n
 VNS/qw7gx7oHR+pdkO6O/XUb9OuD1dJP8uSOqSmtt2QDtqhYIGnCfj7Dea2r8G0FRay7u+9uh
 EAiZqXiXAREZM7EnOZH5KT/6b1/rr0Y9nrvrhIiRZy63u6/8zcGR/fgb3H9h3o9oT8Y1lOsTu
 3cqfTx03nKOegH8EtbqzC4NISoryuSrRd+9gjG7j+jkuf5p1zPqwNOTwKYu12wRmrrnDDjYwi
 CT3YlO9YcYqYH2Q69HAPG+CzAHoYHMjAaXo0bcFc7rsXwU9qMJfrDIbbA0zFMHGtLxuFZvYQt
 S9QmPncrnTXqLFOTSs/nxckaefEOeKF8000qrNzDjrvaeg1EQ7Xmjt03LPekOcETuhg7Bva7Z
 ibPTcy8aFTxrkhsDezdiIay+1GBh2V56WlEfN6jpIpuhYWDJEQ4AQyCV5OGw5uYoEqwsUAtj+
 Ok4CXM/dOk5+U/1OgSag1QKtdHM2kpJm+FC7hH6fRKhHAfb4wseNi+UE5KHtxdH9FFwV3FiE8
 QC3+xQ==
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

On 12/31/23 16:25, Simon Glass wrote:
> Sandbox uses an API to map between addresses and pointers. This allows
> it to have (emulated) memory at zero and avoid arch-specific addressing
> details. It also allows memory-mapped peripherals to work.
>
> As an example, on many machines sandbox maps address 100 to pointer
> value 10000000.
>
> However this is not correct for ACPI, if sandbox starts another program
> (e.g EFI app) and passes it the tables. That app has no knowledge of
> sandbox's address mapping. So to make this work we want to store
> 10000000 as the value in the table.
>
> Add two new 'nomap' functions which clearly make this exeption to how
> sandbox works.
>
> This should allow EFI apps to access ACPI tables with sandbox, e.g. for
> testing purposes.
>
> Signed-off-by: Simon Glass<sjg@chromium.org>
> Suggested-by: Heinrich Schuchardt<xypron.glpk@gmx.de>

Thanks a lot for making this change.

Best regards

Heinrich
