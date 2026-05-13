Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98B4CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 16:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE998341A;
	Wed, 13 May 2026 18:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="hdcwsEXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B127E84663; Wed, 13 May 2026 18:05:03 +0200 (CEST)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com
 [IPv6:2607:f8b0:4864:20::132e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0461080F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 18:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so11845335eec.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778688297; x=1779293097;
 darn=lists.denx.de; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NQccJVrmZbdJHJ3GvM+ZWLCexPtPjS9cPS55GSUjwtQ=;
 b=hdcwsEXYCGuvoCs6RjVAfuMM6rxQ/5cNDmX9UfxcNO2xxIcuXsl6aphVuy5L3qkgKZ
 Zdma9INHQ1CDm3dlg3drEK0OFwWqPerxh/QmyYIN9y2lhV8BvynwKaF457yUi+QpYjDA
 KkQqk/hqOHHfrljOElOkPVMqWwzM7mpfOwU2NV7OFPqyGZIXWyViOdbRUG8tYSHQ93MJ
 yoR99l/9d4V5ZdAaGjKbkpuMvIJowYNoE6bQPY/cNGS52cg834ExrQxGfDKXj6AP4tu6
 RGHLLZvX9US9UoZrxh2F9GY3kww0e4WokO91it22x6xDrWLkeNTnvePBsqLTbhAuq2Iy
 LwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778688297; x=1779293097;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NQccJVrmZbdJHJ3GvM+ZWLCexPtPjS9cPS55GSUjwtQ=;
 b=XW7oSnYwx3K4eQ3XtRks4S4akFmHUB1kCed5MFFNGUXjP00lLdWMZDfJLkKVYte+K7
 jOKUevqMAqOwcwJA5BtLjs5dJT5rGnWhSRPbXOdaV11ZaNDNGWSbpY2Unr4849AglYdI
 7hztScP4+6Ivme/uaa4ARMTlk6Fdj4joAU0z5gj2z6CDE2QqNLUKuSJO/T41lhfPDT71
 ezdlmGP+6eQMAN6pHpOiWCvRAuUpKxGb9Fqju9FmceJTBikPWOdDurn5WlyORDBiPy8D
 QOEIurL2u5k1PRAhMRXiGBg1Ysc13ZPTojOSI+VayuOki6uUYTeKsOF2r3ce0gvAfOns
 XV4g==
X-Gm-Message-State: AOJu0YzZ8HtLCDVg6UId9ul/UBxuup+hXGcjOG5o8yVsHZPvJOkX5CPf
 mjhWjz+hfkGDMWn542gOoZqdz2fEGbJVe+Q5o9NstqHuvIjkakW29OIFKbrq9t+NaPk=
X-Gm-Gg: Acq92OGMFW3vkqiEjeE+mwnba25WT8pLm/k+UTo1M0Cvgh2WdtqNEFwCFO2ybZCPy3R
 phiXyL/yISiGfQOy/1WjcbbWXwZU7Ps7cdte/JVTHSeBHjaf16LVl7zZMkYBtEOyPIY2jJqpXnG
 rcGAlt/nydlVGYTlekB/FHW0VrPsYNA27iIE91ogvwZE/3Yg9Fjep+ynVmL/v/JHPS1cDqu4f1P
 dASN3om9eewQUoLgEAamLz6VUfGs70zRlQMNFM55OvuRcjt05Mi8KE8Rpw8YHLXftL/+90IqbRD
 A+ThPSyMLo2jToo3AZP+rtlmoPFxMQufem5wDuHfLBy6CxdqMn1/AbGleoTNUE3zEsu5s/yvohC
 /PaoPWCxRu1zFhxRFfVjoz2Q9z3SJZ0b56oSKVVlog+rrA5zg+bmZ07rGecFet0XrZccgBb04w6
 W5NPErPXhT3ORfhSmVZ4tOnzvsj01LlikIaUlBqFmsbUFS4xHgLV+Yfamwhua1WHBcfKRbURDMM
 3FAiSp062JSm0lJ2UjdoDz5VQ==
X-Received: by 2002:a05:7300:e12a:b0:2ef:83d4:647f with SMTP id
 5a478bee46e88-301565140c6mr1848582eec.25.1778688296981; 
 Wed, 13 May 2026 09:04:56 -0700 (PDT)
Received: from smtpclient.apple ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e381c9sm22468891eec.26.2026.05.13.09.04.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 May 2026 09:04:56 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
Message-Id: <39404C01-685F-41AD-937B-7CCC4501F9D3@wolfssl.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.21\))
Subject: Re: [PATCH v4 00/14] tpm: Add wolfTPM library support for TPM 2.0
Date: Wed, 13 May 2026 09:04:45 -0700
In-Reply-To: <20260513143423.GU1858239@bill-the-cat>
Cc: u-boot@lists.denx.de,
 David Garske <david@wolfssl.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
 <CAC_iWjKGzwsb88AEx=Q5nibTnqpMf0j-tFxaPsjKrpmGfUCpiA@mail.gmail.com>
 <20260513143423.GU1858239@bill-the-cat>
X-Mailer: Apple Mail (2.3731.700.6.1.21)
X-Mailman-Approved-At: Wed, 13 May 2026 18:12:56 +0200
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi all,=20

Yes we have moved all our libraries to GPLv3. We have made exceptions =
for some open source projects to allow GPLv2 see here: =
https://github.com/wolfSSL/wolfssl/blob/master/LICENSING#L8. We are =
willing to do this for wolfTPM and DENX/U-Boot.

Thanks,=20
Aidan

> On May 13, 2026, at 7:34 AM, Tom Rini <trini@konsulko.com> wrote:
>=20
> On Wed, May 13, 2026 at 09:35:44AM +0300, Ilias Apalodimas wrote:
>> Hi Aidan
>>=20
>> On Wed, 13 May 2026 at 03:26, Aidan Garske <aidan@wolfssl.com> wrote:
>>>=20
>>> Hi all,
>>=20
>> Thanks for all the efforts. Unfortunaltely I don't think we can pick
>> any of these up. WolfTPM is listed as GPLv3, which is incompatible
>> with U-Boot [0]. Tom am I misunderstanding any of this?
>=20
> Yes, as I understand it as well (and Peter raised this question on v3
> yesterday too), this is GPLv3 and not GPLv2 (older wolfSSL used to be
> v2) and so no, isn't compatible.
>=20
> --=20
> Tom

