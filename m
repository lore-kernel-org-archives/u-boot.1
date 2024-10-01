Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE2ECEB2DF
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 02:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE5FF8904B;
	Tue,  1 Oct 2024 04:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pL3d/Q/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011D4890BC; Tue,  1 Oct 2024 04:35:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B44D189042
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 04:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727750099; x=1728354899; i=xypron.glpk@gmx.de;
 bh=AXSUoJRk9zpSp2K/qnyRSNL7ouEAUp1Hf/QCixl9sY4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pL3d/Q/EKvilXXll5T6xPMS4qdotGwp2LU5rieu8k3sKlaYPPHDzprXesW0V1b+5
 MSJmpWbGqbHLNvRsc+XHNcCJYhaK7wHxwux0h+WuIBOqD2bGmrCDIYN81vdEGupqi
 kHA6JS/oYDRrEuz17VNyJjyVW9l+qTok8tQM931wwN3WBABWfGR7MWBXisZtJy0uo
 +0CfDaVZkxNAkKOCBJkp1hvx5hnuWG0cMP48vm2eeNVrq23285mTIpf+58ylmlLPU
 u06KCVPWJjip9elyh4/us94DiHg0OisKN7OhnoF4TQwkNGlcTUQdMwdtpKfBsgQcW
 eqbihZUzqjbj9WEnlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1sHz6Z2yFE-00Zn2D; Tue, 01
 Oct 2024 04:34:59 +0200
Message-ID: <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
Date: Tue, 1 Oct 2024 04:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241001002442.GC4737@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dNDcfYaNQr1f6O6lERrVV/HRB71V1uGwzxJC3d7Qw6syiOjanY8
 puMoqcUB62C07FCblB2edsNvZfFEc7maUpqdzcqtbHFiuj7t3dBZ97AD3PNpZcWcCaenVLC
 GiMLdigyKTr3lgr/nes531l55qtOyAZaDxfb1yuPY9EYEYlz7XL4ic07NAU+uLmEgWqZSBQ
 0XFs+gNDLktarOOAiYHRg==
UI-OutboundReport: notjunk:1;M01:P0:nywqxFZU2Zg=;K0XPuu0T8wg1xUKJPb/+Hx2S4H+
 GHeofIWgE0bxGsdaMUAIVR2oTNVA2GB/dVRX28iyjhsf18idTxiKH8DWznVoL5WOUxGwDvIXi
 imJ7qz2pUZeqa8GaQ9Scm1E/WwrOlkjFhO4/DZpfGl5COkpKoEyHLClOQBepOxGIKCVmeCh+z
 yuFCK8o2kVC1AfLF/DtUA3+F+BzhiVsUW05YCdiFJ+Tw1eqzv8L2ec6aWZeGRQyOc++DZJgvD
 vIEI8RNX5BUbK/d/69DbBMO4OhHC5lLadz9rw2mBTmVsoIm+qyoWwKT1gMjyoySQjeWCxKcn8
 sUjowEh9vgFfx0TLknyvvYiDUkrnc0lZWlDuwapesEMHJTcvX9EPVngo2mWfRJY5dgIeFvTaK
 8RsQ3vmndsqdC+F141WILhaNW1bKz5X14/CAK921ZmJvmwK9+DYcv41WJA3gr0pUs5AUaTWqK
 gNb680OzNHNM4uIEq14s/uyDIR0ZfkYtj8RlFIQjDM4CV4uxP6sgnbXAbZsQ4UQIwnH+GivtB
 EXY17RhlxFiEuoWXdmU/AAw9zAv9I6NgplL6I7Z+78l0rlZeusgMR79bgXJjaEUkk4qeI/el3
 sOCmkPR9NtinOQeN3zD+YinLRxUfTiCOffVzvIDR1y5GZV9Q7CTTxkGp3BsCRmyYnEUEAmvAb
 6U2wemgjr+WMl1vx+b4CjK9dGFFCEkgbTTz6dK5ifTx4kfTYCkyDeH9ghN7sXZR0+thlPjIvS
 V4w86H3ViHEciZttA1MAzE+BspCw8MKIfXHTyb2z4mGcnEam2RjclmmlCZgfOuMoKWMVSznKm
 bMJMj4z4bxoLXWtKiWKz0muA==
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

On 10/1/24 02:24, Tom Rini wrote:
> On Tue, Oct 01, 2024 at 01:38:56AM +0200, Heinrich Schuchardt wrote:
>> On 26.09.24 23:59, Simon Glass wrote:
>>> We don't want ANSI characters written in tests since it is a pain to
>>> check the output with ut_assert_nextline() et al.
>>>
>>> Provide a way to tests to request that ANSI characters not be sent.
>>>
>>> Add a proper function comment while we are here, to encourage others.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>
>> Please, consider prior review before resubmitting patches.
>>
>> As responded to all prior submissions:
>>
>> We want to test the code running on actual machines.
>> We don't want to have sandbox code everywhere.
>>
>> I cannot see any test that is not passing due to the current behavior.
>
> The pytests for the EFI selftests are unreliable for me, on Raspberry Pi
> 3, more often in 32bit mode than 64bit mode, but I feel like I see it
> there too. And when they fail, the console log is full of ANSI escape
> sequences. Is this specific test a test you run regularly on real
> hardware?
>

It is not only the EFI test but also pytest adding color to the console
output.

When I download a raw LOG and display it with

   wget
https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/904222/raw
   less -r raw

I see the correct colored output. Same when I run

   cat raw

If you want to strip ANSI codes from a file, you can use ansi2txt from
Ubuntu package colorized logs.

   ansi2txt < raw > flat.log

I typically run UEFI tests interactively on the sandbox, virtual
machines, and on actual hardware.

lib/efi_selftest/efi_selftest_textoutput.c is specifically used to print
out all combinations of fore- and background colors.

Furthermore color is used in /lib/efi_selftest/ for:

* start of test
* success, warning, error

This coloring is not functionally necessary but for my taste makes the
output easier to read.

test/py/tests/test_efi_selftest.py just has no problems with the color
output when running:

     if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):

While color output in UEFI unit tests as said is not functionally
necessary in most tests, the current patch tries to suppress ANSI output
which is functionally necessary and which probably should be tested for.

Best regards

Heinrich
