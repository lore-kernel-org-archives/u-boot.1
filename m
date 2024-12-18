Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A479FE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 20:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE078022B;
	Wed, 18 Dec 2024 21:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=alessio-randomstuff@web.de header.b="NxiA+Vhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF8480291; Wed, 18 Dec 2024 19:45:57 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F378021A
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 19:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alessio-randomstuff@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1734547555; x=1735152355;
 i=alessio-randomstuff@web.de;
 bh=KTPUCiKh+CwLjEQV+298G7FcxCj87sn550ugiNl18w0=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
 Content-Type:Date:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NxiA+Vhb2WHrN3JFJsBYRfMIq4x88E0tt2mFsLOg4v0wQ0C7dFqJMUQSE+cWjtdR
 sKU9kISgF9pxnMKyXpwVbk8fNlRdfk5wCjKmh+i9+cm92xRa7OS2JnzdrSX7urlQC
 vNtR7rCYzRXGKlpIOhuIHy5j1HdTmgeX2pXmgI7zd9Wrqz/9vh9TYqZWNWGYv+DD4
 7S05eh5xq8Hw0dWD10rKXfM69W0MrYAJyA2s9HAzHeExdAS64rX63aTxDHgotauWz
 gDpVL+bGDxMKkQYWiXTrn8cF1XXEUxSZQ54+nkt7ZoKgbPW241sPpgw2h9Df0R9R1
 vZwc11qhsCW5Bcy5mQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [77.7.93.74] ([77.7.93.74]) by
 trinity-msg-rest-webde-webde-live-56785d657d-ppg5j (via HTTP); Wed, 18 Dec
 2024 18:45:55 +0000
MIME-Version: 1.0
Message-ID: <trinity-f5006f12-c560-4ecf-a580-519a9e495ced-1734547554931@trinity-msg-rest-webde-webde-live-56785d657d-ppg5j>
From: alessio-randomstuff@web.de
To: u-boot@lists.denx.de
Subject: Help with Falcon Mode on STM32MP157C-DK2
Content-Type: text/plain; charset=UTF-8
Importance: normal
Date: Wed, 18 Dec 2024 18:45:55 +0000
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:RgVLWQFdK8QHDKeeExc8b+ugAZayFUlmFcYuVgMDROewt8uEkiuMa6LFwetaNcCFw1guA
 jTIBj56RI5VDWIUdwDHndFF2oESlN8cOI8Eisp57Nv9lBqmp44Zhz/fiz5J3P3vs/6OP6BhkkGEE
 oLsVrzGfmpAzzk0yMj4+6d6qFJJoQeYPeNZRrCIKwzQZX/i1sgJ6yGCcjQumroPMt/oIMiBp69W1
 TIK7CzU4NmPqe6XCZHwKqyEcyJzjRiB0RfJSFKaZtzass0j0yvSbtHR5vCtO4Hos7KS5eDHrHkPO
 RJKUMb90FsXcKRrRxt02w5jKzXculcWbEIitq2guMvZTbzhyDWQxFU8hgcWhOTp+v8OSBq6SvXS8
 yf2mvwFFnFj
UI-OutboundReport: notjunk:1;M01:P0:26Rh3Rd0rFU=;a33Sp3Ce6JfVW1ryF3hwnPSDPKj
 IOSvTnCt+IH/h6TsXxz9oebQM2YfXZ6kyEFYXS/6BHh1F9SnGtaF3JrGDpJfmMJdj8zANNCPL
 2Mi1Fm5qUykq0ztKKeUbprXHeAqxm10ysuM+hFSeKt1Vys36SA207CxDH7ROsG2CybIWh0Kv3
 abnCR1ykusoQS9WbCHme8WHgNNzZvFXcCodgJWwDh6ciPE6YaYV25piGfd8ddUFpCcS76Bxj3
 zJdLLTpDYYUK9yp0W4AaNQyMRWmEcMiojj9VtAkfpIExl95wkoS26VSE0oAPQnveWDZYOUDpR
 h8bYRNRdIVP4kCeWjWO3WST47vAzaDtUsQ+RYqR+wMsG9ogGP4dzqJPZp/iR7WyjS0H8VhREb
 EoFW9JsjMuKV1pAwfvEtSd7uAwGbMEVGneNmc9fmAJ7W4FlVtW8Ue53CuCeTAnSeFX1AsnvJY
 WG6RqTETUvsEvfpja0PnbaiJKffA9oFjmJcXy0PONUWawWWmqLXwoKyphj1BjiFVwGUF9+QHU
 iVpu5dptrBH/mHJSFErg2vgCLzOGSRz6eHofnNbw6yES/J30uNPn1uxcTGOQPgOd8L5Aca5JC
 0b5l6ul6awF5nuB47m30jqh0hZe//ZXQEp5WGclIcz9n4anvJX/qVGqRpCj/yExfwvCoaCr5W
 kTIeTpNQ9LdeVtDr+Ar4231HB1mfpBeMHQB90d+aGzIDO4qkslFeZrn7w0W0OjqWRg5thEgQ8
 dsH25lfOYi+PgVOqUYxIH43wBX/1I06zkL7DAC5sCiff8V7t1hd7qD0gpbfjfsp59Ek4rx1XI
 zKl6j2s+RlePULMANzcThXnptpQenNkwssxvZpRVzkXRUlYf5xiruCDTRAglVJOrV3TRMFenV
 Kda+exob/lPtWqw==
X-Mailman-Approved-At: Wed, 18 Dec 2024 21:41:12 +0100
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

Subject: Help with Falcon Mode on STM32MP157C-DK2

Hello U-Boot Community,

My name is Alessio, and I=E2=80=99m a student working on implementing Falc=
on Mode for the STM32MP157C-DK2 as part of my bachelor thesis=2E I=E2=80=99=
m relatively new to embedded development and would greatly appreciate guida=
nce or collaboration with someone experienced=2E

So far, I=E2=80=99ve modified U-Boot logs and built the configuration usin=
g `stm32mp15_basic_defconfig`, with the following adjustments:
CONFIG_SPL_OS_BOOT=3Dy =20
CONFIG_CMD_SPL=3Dy =20
CONFIG_SPL_SIZE_LIMIT=3D0xB1000 =20

However, I encountered an error suggesting to run `make mrproper`=2E I sus=
pect this could be specific to the STM board=2E Has anyone encountered simi=
lar issues or successfully implemented Falcon Mode on this hardware?

Thank you for your time, and I apologize if this message doesn=E2=80=99t f=
ollow mailing list conventions, as this is my first post=2E

Kind regards, =20
Alessio

