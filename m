Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149E6C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 14:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4A98755C;
	Sat, 16 Dec 2023 15:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MYdHEOSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED161875D6; Sat, 16 Dec 2023 15:50:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1464587525
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 15:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702738241; x=1703343041; i=xypron.glpk@gmx.de;
 bh=0Ilm52WSz2wPkqAc4WkebTmt4E9kUqOixI+nxnxVhx0=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=MYdHEOSNI5YVCml4IS3j3GlS9rJxkk8hpDYOZ+okmR4AWiSBZPahzxIrlqxzwi7a
 Z29/oHCFonnAx8Cu5RPMRX7gqLS5aou9KWa1JkGpD9/QLRNnaqshYibz9h++Fgihx
 /U8kUh+AKtFd1VM7If4qLnDbQYQhSPV758UVFtXgHhE580bkchI1ljEpv9nViMxsy
 v0FRPpiUWYf9TTpccdEsYlkm6WPh96ceG46TCjDyN8awZjNeDwiw5SOMqwKnS64ej
 Y1qJqZ9RWsdvgmS2n0AgfJR4ZQ/1JFRrml4PTG7A1RWfWVuAlEloF25bJXPQaMeaX
 hO/DYVC2A1eNsXppkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.0.170] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1qwz7A3wYq-00Hj9r; Sat, 16
 Dec 2023 15:50:40 +0100
Message-ID: <acfe7ea1-a25a-4293-9e05-bfe4ed7c2a05@gmx.de>
Date: Sat, 16 Dec 2023 15:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Booting fails on the sandbox
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zz0II80iDT3TEWzsprYjMm2ZtqcQLGh+dhbPIfWOl4HQY93MrjD
 4iBaEwJJuQ7LquhlQuvO4zDQFiGUxo1GDWegUmQtVlm8RIlF5j3keYQeSMKCTauXjxGMFNb
 U49FaLV/xZxTzpDKKqg8B0jIki4dPBel5tFrGewFQa5KwnhYDgnuT7y3Ng42r60cYJCT+vf
 YKiMYYKpBLi50JKjOLb0g==
UI-OutboundReport: notjunk:1;M01:P0:rKE+NIdZGZk=;KsiVujRxCXi0HWQuVn6tay0B0rb
 58WWPoov4ggAnjpXkqV/DtSj6bhw42iBaikJiMTdPjlFCASbkPwg2xHbk6po7ye6YAg2MF/Gd
 ddtfvoS92gi3xMEFFJiMFTK0kLI9kzgceTnpTg/q+pcZyq7/hvS2peTFp8ndRRC10fyWES0by
 FP25amDdOzeg2YkxZEmdlLeanTvOLzR41SLfRW8j979qu0ybGLnGMcMwEiGIXjZKFDLLcrxy8
 RBH2YUGYldK5nKSmARWfEdDUwa+4iz4O+kuO6AK0ncmQx+Eh0C/dQhLeAdCik+6yzVyEZt1nC
 T06t5e/8w9YKXhS1VQBeaordBnyhCEOQ6+9uAvTnr25VeGe0e6Hx2BkrkwTsptWaCyBDvVter
 NqjDJXcGSUFueVQ/kN/EAIGhK5WYaPswBF2UWiYePyGu+nPrIXqX6MNrnAIKk7sI94ZBY+Duw
 k6qLBCVFsdfPoK1xw3G7oDIMwbelXGfg5C0bqAS9shRSkteh0QBs/U4pQgyONzBx619PtHlgP
 XPdFN8nJz3I7ev+P4xj8+mfCMih//LzdCVjrAXUiJnah+zK7iKMl451PEx7lkdGr5Q9JS0Nxu
 BfXfedCIFhRIIzJjxc2/4AIpbOZrAA532fg2K8NrSTCMvax33kcq8KeFq4aIIo8TwI18wVMdx
 F5XOok3YF9F40smED4S01el13MLjZKOjO+G3JWlKBzDP857E5LFmaNbokm0f0LB/+9xNfC5Z6
 PQkTlTdTfyizIY/uF3ox55lp1UFxYGDrLV4YCUzizJNwUBpthgspUpR0qDyFpMxrOC6DqR5e3
 lUEmxzRCpVDwukGcBeVuVLlWrNvdCI8Q6/qWvZcrm+f3JAxr7TA3140ZU7gK2GYsYPhr43Pe+
 prB/4WvilA4outDd5DtkXf4Z8tYze+yTX2rqeGfFk3zxVH1qBbpIxbCLxnfhY9r5jg6/ociQn
 HpAgJ/6cfjDn+Xdt0SMm4192IhQ=
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

Hello Simon,

I have built sandbox_defconfig with PREBOOT=3D'host bind 0 ../sct.img'

On the image I have an ESP with file EFI/BOOT/BOOTX64.EFI.

I would expect the sandbox to boot from the ESP.

But when starting the sandbox is does not boot. Instead it shows a menu
with some Fedora related entry:

Fedora-Workstation-armhfp-31-1.9 Boot Options.
1:      Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)

This makes absolutely no sense on an x86_64 system. Could you, please,
fix sandbox_defconfig to boot according to distroboot.

Best regards

Heinrich
