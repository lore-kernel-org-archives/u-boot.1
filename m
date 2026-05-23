Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6729CCD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 14:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D862384879;
	Sat, 23 May 2026 16:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m0l0yaxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E51F84886; Sat, 23 May 2026 16:17:21 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8885B8486D
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 16:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd56d108454so1545911166b.2
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 07:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779545839; cv=none;
 d=google.com; s=arc-20240605;
 b=WNzas6F9v1LW1rYgQeiq1XKjDc4OfjaQVCx+Yw9biQJ/QhEwpMXSXGPzpan8BcrIca
 TCIc4Yihoj+Kumk29pmJvc59P+ED2cPDfMP80d2yw55GlgkeGRrcP6W90xsEEUmSnkmu
 UKfyPSQfje9hHlZqfzKhNPtD5/Cv2Bb1Qigz/bD0yGQwCh3GGeT8jiVdTQcOjxLVd+7t
 Mwgjrxcurqa/nf14yIeuzyNlkgl9KawdvfkfJWqrqNhKHCq7v9o27Pov/Cew+gKtxk5Z
 TmRdrI/0iw4XVNgTgUgskFwEoY5hz87R40D3jfv2Ox8DqnEV7492th2rb8NkjdHRft/2
 uy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+tlTYChdcL/ZEP/WYPNNz8HwP8h2d9ZbplOq6GAidC4=;
 fh=24zDFb7Sg0u78TsG+jfjBOK0JV4gQ1Mbok+DugbRoyY=;
 b=SAmTbGd+4mFGcFlTpygLY30XEAwyHbBIWFcj1IuEHQQiCXDck1QvdMeWImOGUopYye
 2uwHzMiX0xiFPoih4770ZMwVJQQED5alk9f3XdPXpEJTYpYJeJ5bzUrP5XZq2f5RUKyl
 1ObTHc8LA8qRMIr1BQSKPBj2nBWB5osxymMOklExkGHvH92iy6mFyor7faZjBF8HOisd
 g/q9nqnZMSju+JKcLh2O4yEjj0AKGO5Glvsc16jnO1LGOGbqEgThypnkYYkv+SjDxmhf
 qBJLrY/dtjNGaaz3+GCpRygFbQK9CGWnNmzsw8ioIQZwaNDr5eLaxrbAhxpv8JrlJoUk
 CUjA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779545839; x=1780150639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+tlTYChdcL/ZEP/WYPNNz8HwP8h2d9ZbplOq6GAidC4=;
 b=m0l0yaxH9eWm1b7fo+4EMo5qNUkmSJEmF2KIHE8hkNgmEJbbHEbJZ1/dJ//I3kHyIA
 DYqaYZ2Nrd3vLPtPhJ1SnXli7hQ7oOWX6VUxh+DmDHygISg+J8buT7tVaGpGjhMHxR2/
 ZfxJHtglEIfoAz00HdDEtk2E7L14eFDj9Gmjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779545839; x=1780150639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tlTYChdcL/ZEP/WYPNNz8HwP8h2d9ZbplOq6GAidC4=;
 b=gc/pk/e4wjO+kRgBGwKi65Vku7favoU+hiAV70N1SV2dwIEmYX9wSRAQmXmcs2ulkS
 PCCnoLN6DfCOBngkm1qv/LFntLnPLYWMrFkbuic5ChU3PtJu25a4Iiy2i+Bij73q7vKV
 lD0eh04xFS3u0GCE7ldhwSpxm5AAGQuL8rVgjnCoS5QyqlEulbCwdCOIb8S2qqjBKZel
 obxzKLfLCrTDLptsL0s+PK48qkbpmWwe/T0wC+7LCyDMh5juodLF67OFFVN6aSkgSena
 ZNB+SuVHWP6OVN5zja+QnRAQmh3aSHX9wTvpP4/KHSGqfCJsbAIysji37ZLhM6VcLcRr
 cDmQ==
X-Gm-Message-State: AOJu0YwmlmtrHYdf65g27/jsGS9AmszU97AfgoeKWoSLRF0Pte+JhWYL
 J1PO6pOfrq9i5RryxTcd0rt2/h2KcNSHwZ4l/umuHlXFP2DfGllT0APi4844plU9Talu4kFn2Qg
 fM6TtBnkJiEojz+F6rc7F/7xYiHJhm8IVt2L8j9hQiWSIvUwoloZ0Yg==
X-Gm-Gg: Acq92OEDDWg57KYon3wnSqSGa1cHh5N/4WbEH29mWHPxGqhaBO5pNiIiFNpWKxIcy6k
 6FiflajQWJ/q+HvjEqWIo+3T0pIbrRNqoeJecXBduVbLWx+UJ77mXp9B2NNFXyrv8smhmEF1jEF
 5tmrC+IS9OREmW+gM+fkOzMxUn8uibQXSRmc1ybzXZmcbQugZVjQHiWzHKczc05VJtHkP9ojJua
 gsVyMUzk535c1xUid/UBLY5BfBnefpHhra1D4+3rBoZ+Y7LolRc1czTw7vaVMW/nKsr0LGiCk6d
 Cnm9sg==
X-Received: by 2002:a17:907:e98c:b0:bdb:3dbd:4953 with SMTP id
 a640c23a62f3a-bdd22a3db89mr497980266b.10.1779545838912; Sat, 23 May 2026
 07:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260505074025.1322104-1-love.kumar@amd.com>
In-Reply-To: <20260505074025.1322104-1-love.kumar@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 08:17:07 -0600
X-Gm-Features: AVHnY4Kz43yitCD4qq5v7o3l28o80LUPkEXsqsfJL8toxtHJUTdktDL7JCrp5L4
Message-ID: <CAFLszTi6txJV-wYzsdN2s4q=F+ua4LvRRb45C1=P9-XUry0byA@mail.gmail.com>
Subject: Re: [PATCH v3] test/py: nand: Add tests for NAND flash device
To: love.kumar@amd.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Love,

On 2026-05-05T07:40:25, Love Kumar <love.kumar@amd.com> wrote:
> test/py: nand: Add tests for NAND flash device
>
> Add tests for nand commands to test various NAND flash operations such
> as erase, write and read.
>
> Signed-off-by: Love Kumar <love.kumar@amd.com>
>
> doc/develop/pytest/test_nand.rst |   8 ++
>  test/py/tests/test_nand.py       | 237 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 245 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/test/py/tests/test_nand.py b/test/py/tests/test_nand.py
> @@ -0,0 +1,237 @@
> +        output = ubman.run_command('crc32 %x %x' % (addr + total_size, size))
> +        m = re.search('==> (.+?)', output)
> +        if not m:
> +            pytest.fail('CRC32 failed')
> +        expected_crc32 = m.group(1)

This regex is missing the $ anchor that test_spi.py uses. With
non-greedy .+? and no terminator, group(1) is just the first character
after '==> ', so expected_crc32 ends up as a single hex digit. The
later 'assert expected_crc32 in output' then matches almost any output
and the test never really checks the CRC. Please use '==> (.+?)$'
(same fix needed in test_nand_write_twice).

> diff --git a/test/py/tests/test_nand.py b/test/py/tests/test_nand.py
> @@ -0,0 +1,237 @@
> +    output = ubman.run_command('nand bad')
> +    if not 'bad blocks:' in output:
> +        pytest.skip('No NAND device available')
> +
> +    count = 0
> +    m = re.search(r'bad blocks:([\n\s\s\d\w]*)', output)
> +    if m:
> +        print(m.group(1))
> +        var = m.group(1).split()
> +        count = len(var)
> +    print('bad blocks count= ' + str(count))

Using a 'nand bad' miss as the "no device" signal seems wrong; you
already detected the device from 'nand info' above. If 'nand bad'
fails to print the header, that's a different problem and should not
be silently skipped

The bare print() calls look like leftover debug output?

> diff --git a/test/py/tests/test_nand.py b/test/py/tests/test_nand.py
> @@ -0,0 +1,237 @@
> +    expected_erase = '100% complete.'
> +    with ubman.temporary_timeout(timeout):
> +        output = ubman.run_command(
> +            'nand erase.spread 0 ' + str(hex(total_size))
> +        )
> +        assert expected_erase in output

Please use %x formatting like everywhere else in the file rather than
str(hex(...)). We should use f-strings in most cases.

> diff --git a/doc/develop/pytest/test_nand.rst b/doc/develop/pytest/test_nand.rst
> @@ -0,0 +1,8 @@
> +test_nand
> +=========
> +
> +.. automodule:: test_nand
> +   :synopsis:
> +   :member-order: bysource
> +   :members:
> +   :undoc-members:

Please add the SPDX-License-Identifier: GPL-2.0+ comment at the top,
matching test_fit.rst.

Regards,
Simon
