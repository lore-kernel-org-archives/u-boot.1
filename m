Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A44C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 21:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 745DF80D05;
	Tue, 25 Aug 2026 21:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dqIAVz6PzaOC; Tue, 25 Aug 2026 21:51:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787694682;
	bh=qcL9B9u3k3p0Dzxzt8AmSOJhhkRxybhT1JgxezXPDVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jNYhBry+D03H1VK+iK2ZQA7j9b4gQPQllRdHakT8l8NqT3tWkrpv2NhDTck32TKEN
	 FYPFCeKR8hvvTvCGF2CkqS24DDmJL1zos3x75tVbmcpddUWHDuztAkeAIjCvmardsl
	 h/ThPgk5VP8K/CMVPAZvB67GGTbkqcRoImTAS3j66KSqAY4Zt9SUIziw3zWgqx+kUe
	 WzA+QN0jH9kGunkEFr+mWJWFNQAxkpEwy5cLqqATysKyj+8LqloYis0h+FleEz/jmW
	 BL12lu4c29GUXY6LOa8qb7Rxzd1+wFUPSEILDnfKZ2Q+7nIJYU9Nh75ijqe6vAMlj8
	 jD9RL/QCCkF+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C3D580C48;
	Tue, 25 Aug 2026 21:51:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 47EF0396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39EF54008D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJj95AGjuSk3 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 21:51:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Gvi0y8/f
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D998240055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:51:19 +0000 (UTC)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AADF53FC0D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787694677;
 bh=qcL9B9u3k3p0Dzxzt8AmSOJhhkRxybhT1JgxezXPDVQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Gvi0y8/ffaeNmnJo0I6t1grxHTqKVun6CBXD2QrVOFnp+ecbUfrHHlIVd4uB/mcuz
 Ydn/xnOou75TqZ6YblqX/bSt1roByjNDkveZyNeGk/tulXuOs037Qy8Bdo9YnhzB9t
 Z3vQOD9F0yzH/1lQTTEva2R9l/l3juH794SCZoOKYhF8tj8kFwjAirI8oGDiNJWZOh
 k2hRjka5pvJi4pDwkgvS8BZnOtqrOuuxojF4qPs4Ly8Aga5xPFkRyEpBVoDZHFyvkI
 nJIFLWHqrIYGpL/kvtSgW6/apy1SdKieqtHJGmMUr7pOveSsLIMAZlOscNuIMSpbly
 7Q95FwPqLVqoiQKjkLBGGU49Xs8sc7O7XlDABYrzFsi/X7uQ38Nz/7VxveFVmMzUxU
 9k7wCcKrBx+wNLcpYrDwbi49kPALZ7eXqm5Ye61/q2ppYH6hBDM2l61SkumVaX6v4H
 brfaj/32T5DNxPye7P/UI8fg+yaA2te/CVt2KzJQk5feocnQ0Yjc5YVkvcgXLuaPaq
 PGogdBiBy1dgm419xmMuQeaGZtyL/VysxRnfV0JgdYL6VYNJWkqaioRTVEU1iOs7OR
 FuwL1+lAauWC3KTSUZ2ZV2++xIMIcBha0ar3J2jdb+MnscIcSdPts1rrbe0qwvfB9E
 9ERZ+Q4kZ4DEgw7DpmVlw5Bs=
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c15e6109f9aso13088866b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787694677; x=1788299477;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qcL9B9u3k3p0Dzxzt8AmSOJhhkRxybhT1JgxezXPDVQ=;
 b=Ih0fCWFt5pXwSfeJb0On8NTkAIRv5CVyFcwyiMxS6bYn1H6OSYbzd5Bi8oOOs+DMhj
 xVgbe2ygpf6hgj45EbEI6+WE12GZnW2Hg5TcR4BrV4N4b4zymKVR6vQ4z1QbsHuajNJL
 EJAnYWAw4E2+yLNKly1pH5pgST+2ax5duqvCQIUUejJL2JL2SebTM2nOoiuKWccBYeCV
 yF4opIHMA4tjgWwFGT7RM/8MTS4vcdWu/AuPQApoK5eXOeLNA3LIyUathliNMJmrIpMA
 jemIEHHtvbKPprBIIbp7b0fFlAl1gJKgjGATTiFSjsgOTwm6m3NJj+HcYlWbWY4udcOz
 XsvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRRwPF63UjOae+kxRMA7GkgS7z4lRlbpsffJs8qqlH0KALs6yp/15AWS4gsRBjNj2n0+6dcCk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nBnAvW3eXdwWJAZHfc3JOWPirXesHYy0MqxBe/46pXlUXhzcvy
 vSiPMotSTOoH9OaC0Jqshh6nmBo91GwsYaXF/Zp7niiQB7gnpCB5pxYrjepi0Bil2K62ol80dp+
 adA6+/rTFQZA2fzS7uKzmKcrnfa+shz8UhhLZrbhWl6rT6bMuN//Eb61d8Mi7l/8Jd/L1l3yuZc
 lxlMDGsJOXjQ==
X-Gm-Gg: AR+sD10gLaIIJEsObYvvY1nTSTU0mIM65V/lFNEeK6vWsFx5p29ChcdyO65FN8OWGqK
 XoTTnnuULP41KWJ75EJ9WbkN5MkyxjvBJhBNqPROgyI2BZOuSrGSmnewOTlKRn5BqXiFt3yWha9
 tbi/ruS5Bn1EiRnm+BroXem4pPHUxfLGxCQ67+Ajv/EcKZhpIqGp5+ofezy6vCZPLor/igqUyHT
 cUJtu6FgFT/Sk4+YJUpQDMr9lyRaxLZ68yM342iMWT83yKcVf1pCuuqjG/jfAm1bE0xqAi549Jf
 rVEeoH2KC4kVAyXOgSK05FhovqNk2Gkg4JJNBQJJgxPYVHfBanR16mXPg6V6vGJYkXW5+sSQlfj
 +1yvkNjtC9Ywf/N/cZNddkqrt+nZf1+3IuCEXA11qZwCNZXQyOEany6T6T8S1cMEJ9XRvGSz1Db
 2c87yJJt3cVzuMtCMAP9DH
X-Received: by 2002:a17:907:d0e:b0:c1f:c7f0:b433 with SMTP id
 a640c23a62f3a-c250bc09ef9mr207637266b.9.1787694677242; 
 Tue, 25 Aug 2026 14:51:17 -0700 (PDT)
X-Received: by 2002:a17:907:d0e:b0:c1f:c7f0:b433 with SMTP id
 a640c23a62f3a-c250bc09ef9mr207632066b.9.1787694676806; 
 Tue, 25 Aug 2026 14:51:16 -0700 (PDT)
Received: from ?IPV6:2a02:3035:667:9a84:7c86:797a:e54:8957?
 ([2a02:3035:667:9a84:7c86:797a:e54:8957])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d68d1sm168487366b.11.2026.08.25.14.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:51:15 -0700 (PDT)
Message-ID: <11a9bb94-de38-4239-a64c-24806229779e@canonical.com>
Date: Tue, 25 Aug 2026 23:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] test: py: gpt: Test the GPT layout on a device with
 4096-byte blocks
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>,
 Javier Martinez Canillas <javierm@redhat.com>, Simon Glass
 <sjg@chromium.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>,
 u-boot@lists.u-boot-project.org,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-6-a3f1f16b53ae@flipper.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260731-gpt-4k-v1-6-a3f1f16b53ae@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 7/31/26 14:40, Alexey Charkov wrote:
> Bind a blank image with a 4096-byte logical block size, let U-Boot write a
> GPT to it, and then check the result both through 'part list' and by
> unpacking the primary and backup headers straight out of the image. The
> interesting assertion is that the backup partition entry array ends
> immediately before the backup header in the last block, which is what
> regresses when the array size is computed with a hardcoded block count.
> 
> No sgdisk is needed since U-Boot creates the table itself, so unlike the
> other tests here this one has no requiredtool marker. The number of entries
> comes from the build config rather than being hardcoded to 128, so the
> expected LBAs are recomputed for builds that set
> CONFIG_EFI_PARTITION_ENTRIES_NUMBERS differently.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Currently this test only runs on the sandbox.

Please, ensure that the test is also run on a big-endian systems in our 
CI as you are adding patches for big-endian support.

Best regards

Heinrich

> ---
>   test/py/tests/test_gpt.py | 115 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 115 insertions(+)
> 
> diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> index fb4c8ba67d48..823fa40a9295 100644
> --- a/test/py/tests/test_gpt.py
> +++ b/test/py/tests/test_gpt.py
> @@ -6,6 +6,7 @@
>   
>   import os
>   import pytest
> +import struct
>   import utils
>   
>   """
> @@ -45,6 +46,28 @@ def parse_gpt_parts(disk_str):
>   
>       return parts
>   
> +# Layout of gpt_header from include/part_efi.h. It is __packed and
> +# little-endian, and struct.calcsize() of this is 92, its header_size.
> +GPT_HEADER_FMT = '<8sIIIIQQQQ16sQIII'
> +GPT_HEADER_FIELDS = (
> +    'signature', 'revision', 'header_size', 'header_crc32', 'reserved1',
> +    'my_lba', 'alternate_lba', 'first_usable_lba', 'last_usable_lba',
> +    'disk_guid', 'partition_entry_lba', 'num_partition_entries',
> +    'sizeof_partition_entry', 'partition_entry_array_crc32')
> +
> +def parse_gpt_header(blob):
> +    """Unpack a raw GPT header.
> +
> +    Args:
> +        blob: Bytes starting at the first byte of the header
> +
> +    Returns:
> +        A dict mapping each gpt_header field name to its value
> +    """
> +    size = struct.calcsize(GPT_HEADER_FMT)
> +    return dict(zip(GPT_HEADER_FIELDS,
> +                    struct.unpack(GPT_HEADER_FMT, blob[:size])))
> +
>   class GptTestDiskImage(object):
>       """Disk Image used by the GPT tests."""
>   
> @@ -93,6 +116,36 @@ class GptTestDiskImage(object):
>           cmd = ('cp', persistent, self.path)
>           utils.run_and_log(ubman, cmd)
>   
> +class BlankDiskImage(object):
> +    """Zero-filled disk image with no partition table on it."""
> +
> +    def __init__(self, ubman, size=4 * 1024 * 1024):
> +        """Initialize a new BlankDiskImage object.
> +
> +        Args:
> +            ubman: A U-Boot console.
> +            size: Image size in bytes. Must be a multiple of the block size
> +                the image is later bound with.
> +
> +        Returns:
> +            Nothing.
> +        """
> +
> +        self.size = size
> +        self.path = os.path.join(ubman.config.result_dir,
> +                                 'test_gpt_blank_disk_image.bin')
> +        ubman.log.action('Generating ' + self.path)
> +        with open(self.path, 'wb') as fd:
> +            fd.truncate(size)
> +
> +@pytest.fixture(scope='function')
> +def blank_disk_image(ubman):
> +    """pytest fixture to provide an empty BlankDiskImage object to tests.
> +    This is function-scoped because it uses ubman, which is also
> +    function-scoped."""
> +
> +    return BlankDiskImage(ubman)
> +
>   @pytest.fixture(scope='function')
>   def state_disk_image(ubman):
>       """pytest fixture to provide a GptTestDiskImage object to tests.
> @@ -330,6 +383,68 @@ def test_gpt_write(state_disk_image, ubman):
>       output = ubman.run_command('gpt guid host 0')
>       assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
>   
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('cmd_gpt')
> +@pytest.mark.buildconfigspec('cmd_part')
> +def test_gpt_write_4k_sectors(blank_disk_image, ubman):
> +    """Test the GPT layout written to a device with 4096-byte sectors.
> +
> +    The partition entry array takes up fewer blocks on a device with large
> +    sectors, and the backup array has to end immediately before the backup
> +    header in the last block whatever the block size is.
> +    """
> +
> +    blksz = 4096
> +    entry_sz = 128
> +    nblocks = blank_disk_image.size // blksz
> +    entries = int(ubman.config.buildconfig.get(
> +        'config_efi_partition_entries_numbers', 128))
> +    pte_blocks = -(-entries * entry_sz // blksz)
> +
> +    first_usable = 2 + pte_blocks
> +    last_usable = nblocks - pte_blocks - 2
> +
> +    ubman.run_command(f'host bind 0 {blank_disk_image.path} {blksz}')
> +
> +    output = ubman.run_command('gpt write host 0 "name=all,size=0"')
> +    assert 'Writing GPT: success!' in output
> +    output = ubman.run_command('gpt verify host 0')
> +    assert 'Verify GPT: success!' in output
> +
> +    output = ubman.run_command('part list host 0')
> +    assert f'0x{first_usable:08x}\t0x{last_usable:08x}\t"all"' in output
> +
> +    with open(blank_disk_image.path, 'rb') as fd:
> +        data = fd.read()
> +
> +    # The primary header sits in block 1 and describes the whole layout
> +    prim = parse_gpt_header(data[blksz:])
> +    assert prim['signature'] == b'EFI PART'
> +    assert prim['my_lba'] == 1
> +    assert prim['alternate_lba'] == nblocks - 1
> +    assert prim['partition_entry_lba'] == 2
> +    assert prim['first_usable_lba'] == first_usable
> +    assert prim['last_usable_lba'] == last_usable
> +    assert prim['num_partition_entries'] == entries
> +    assert prim['sizeof_partition_entry'] == entry_sz
> +
> +    # The backup header sits in the very last block...
> +    bkp = parse_gpt_header(data[(nblocks - 1) * blksz:])
> +    assert bkp['signature'] == b'EFI PART'
> +    assert bkp['my_lba'] == nblocks - 1
> +    assert bkp['alternate_lba'] == 1
> +    assert bkp['first_usable_lba'] == first_usable
> +    assert bkp['last_usable_lba'] == last_usable
> +
> +    # ...and its entry array must end immediately before it
> +    assert bkp['partition_entry_lba'] == last_usable + 1
> +    assert bkp['partition_entry_lba'] + pte_blocks == nblocks - 1
> +
> +    # The backup array holds the same entries as the primary one
> +    pte_len = entries * entry_sz
> +    bkp_off = bkp['partition_entry_lba'] * blksz
> +    assert data[bkp_off:bkp_off + pte_len] == data[2 * blksz:2 * blksz + pte_len]
> +
>   @pytest.mark.boardspec('sandbox')
>   @pytest.mark.buildconfigspec('cmd_gpt')
>   @pytest.mark.buildconfigspec('cmd_part')
> 

