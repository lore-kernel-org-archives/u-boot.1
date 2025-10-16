Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7663CCD194
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 12:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E81C836D1;
	Thu, 16 Oct 2025 14:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LV/Ymhnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2E483700; Thu, 16 Oct 2025 14:55:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D5C8367F
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 14:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760619328; x=1761224128; i=xypron.glpk@gmx.de;
 bh=gNUiCFYv+uzUm3J8USWeC4QVl/I8d2f7xhwCWkclaWk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LV/YmhnkoqSxb63FzqLY/ZWAqvkaoH3uee8n5tdFKQYaXByl47pR5VcfFj+hsURh
 iE+WKsLOMNJb6ADDhP7IWfrbYjvnIQEnVuJZUtzMcWB7lpzaP9vzvUy1F4PmHNWY3
 A1TShZUCc61HNvqrP13uuRNBI9rbVCz9nc10QqnkgdksJvB5g+Y0hYNKC5UKC4gwf
 YHJ+q/wg1WsY77QIH1I45uYB2gk4TFw+Z+FGSLt+YtZ3uysgbp3SJaqd/gfW9yWN9
 +z1TdPgxVy1Ulc5Dh295M7a2nmnTf3oANSx+7gxbtzUEl4BxP91vhUJCLH5L9Gwuv
 l4YdvddNmr/5auSfiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1ujQNm0k6s-00Pq0G; Thu, 16
 Oct 2025 14:55:28 +0200
Message-ID: <ca4c2345-3eb3-4e5f-b9a5-da29ae6b91b2@gmx.de>
Date: Thu, 16 Oct 2025 14:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] boot: Try all bootmeths on the final partition
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
References: <20251015154423.908468-1-sjg@chromium.org>
 <20251015154423.908468-2-sjg@chromium.org>
 <20251015190446.GS6113@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251015190446.GS6113@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IPzrdSw6h0Dd/2kFlKzW54aCWcWd9Dnbb9XweJpEUkJmUVb1n4d
 NqegsD6+637hwwb3Fkt1c/phZ84GBV+pkx1wfrQ4DSyodf3jAVUEFNn97PdEuusrbpXAHiX
 4K8UwF6aKG3/6JAxHs76PPYRUc9KFHNqLrtiICJFBZ3UI7KHpWUznpZzea41qYqtv8hr5sM
 1jac/EF9bJn8O5htnWkUg==
UI-OutboundReport: notjunk:1;M01:P0:H8Qg9e1TqOI=;AivW8r53vfser4J1u6xjP16LHfd
 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
 xewvQ/ZNb7rjkQ==
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

On 10/15/25 21:04, Tom Rini wrote:
> On Wed, Oct 15, 2025 at 04:44:04PM +0100, Simon Glass wrote:
>=20
>> At present, normally when one bootmeth fails on a partition, we move on
>> and try the next bootmeth. However, this was not the case for the final
>> partition due to a bug. Rework the logic so that all partitions are
>> treated the same.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> Changes in v4:
>> - Reword the commit message as Tom suggested
>>
>>   boot/bootflow.c | 34 ++++++++++++++++------------------
>>   1 file changed, 16 insertions(+), 18 deletions(-)
>=20
> I'm glad you reworded this, but it's frustrating you didn't also post
> this stand alone (and presumably sooner) as was requested as it's a
> stand alone fix.
>=20

I guess you could still apply it standalone to origin/master.

Best regards

Heinrich
