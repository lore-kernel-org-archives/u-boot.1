Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4387CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 13:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF04839A8;
	Wed, 27 May 2026 15:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pua4kwqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623B083FB0; Wed, 27 May 2026 15:36:30 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C822803C6
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02C403F0C5
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779888987;
 bh=evK40uqKhmenGl7BB9yzhQovq+kY+J/xBPovLt0XN/E=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:References:Cc:
 In-Reply-To:Content-Type;
 b=pua4kwqgaui2999pscsTQWHvbA2XFb0n5NKw71s1xEf3g54klDrHPjTfExo94CRLq
 lBIJB4BzEHpaUVZtI44/q/GvZDKCGrXqYJHKLvtJK2A7EIxNa/GiHt6HkWFjj5IUR4
 MekRiwb71iegw+FLag5a1HlNkaj9lE40bytlJjvpI4eLa4g5RgTdGSJeYbUw4X3UIF
 3hqk5t5V7NvxbylkEB2xCL5TwbVb1YMujxep4szX3YnCye4PVRblSC+dhVVm/5cwL1
 CN1bqih03A2AEkMzItXhljTVUtluQBccpCmXMXV2l3KPt/vfBirrnBpk3/zPBbHgiE
 MP/1wjnTUNpl6d/2Lee0Iq/LLPMvAGJmlixwBsTGgq4VYbDREtOVbIgfc2pogODq6D
 DLo9O/+zcWdkpV6RTOw5TLGw3kXWBsOlrSnGmW2w119OGVD08FLd+/JLdsbO5d6xyc
 j20LLiH70E4ic0ouPLq/2BLnq2Sk+ugslj5RNxkBGI5zuvZlRfbCuJ5bqKBontWx1v
 PTyLtFwlJKRwK+MB56vMggMvNENNZvP1rUfCoJ6p+nIXjGTR0vvemOMowUsxQyvhEP
 AUFeZ3vYlOlaOLGx2yo/WDLsO0f6KxnlISYogAqyx5zo+68k+x3l3X6fP7iINPINbC
 mY/1YRroezjhUpq9uifvQoJ8=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44d83e45febso8237705f8f.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779888986; x=1780493786;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=evK40uqKhmenGl7BB9yzhQovq+kY+J/xBPovLt0XN/E=;
 b=kDQdfom73vPOwPWTN6zm5hwXyzDEGSmfSUBIq6HZVVNpGHkAw2q8MmY2lWD27apvw0
 SXnl1g/mxasPCo27O4Ea4sfJyQJ+FCOAWC//eep/tzeybNPZrwSHnDsqNUaXKdYCaGc2
 QJhy+c/qfSfNGKOA+oguiBJvi6SollhG5Dh8Pj4cKPmfRpzYM8eX2H3slMuMymYDNS4F
 IIxe1fi2gzgztXjJallDVtRzPjFBXMKAxuuVlG84UpaZtGlRj4ktxON1voa3VLkARzlP
 5bWZOSANmvXBZPooc7ThZnJoBde+9GT+DxWftKthSeEUxi9RcLAnqaDX+95y8hjlDKBW
 LP6g==
X-Gm-Message-State: AOJu0Yz/f/+mETmLz5gV7F+dBtXq2vtptX5D7O/nicjZ71S/N11B3ccT
 hPtnDLoGx9PjVl4Eh5ct3o94N/Rq7JjTa2TwtWlUtxt+GBGue6cLsogynGFbYs+2tEkrOwg2mFa
 CZTIBooazXmxo5tqfy2vQwQCTsF6S7SD6p+z4zCwSF3YkoHDIPym58bfk/ULCwaKkW02FjcU=
X-Gm-Gg: Acq92OEPFkNUZgRzfnzrH1Sv1nVqg7X4fP3STsx/Omh5y0mTnsu78iMmcGm158Cfln9
 fUVozc8Zk9Ok9SHcSPzhx2gvNxKENFp2HexDbqXk5eBaaUd9ATC5Ypi2D1xqPz3ARIIsmvU2iQl
 L1AxGlIBLGhI4P/YsCgNk3q4AvGTk34HeQBjM7Qi8fMc4D/Ew8lVnYxNHR9aXwUBuuM4hkNoqQ9
 HM5/OuRSI60h6v7JXaWIAr5Xx+3Wd+B7+mW/NaB1H2fIwkUFnhU8J399bCZ3ilHQvZ7GCuondpY
 3a4NEFOBOnOn7uvbg/X8b/l8Tf+yt+BlOYPmGr0zkPJr2ChofpTQO+wsd8lEQKYY7AwGegGD9Yv
 LgJdL2JEhrB+SbSsf7sy0v2jeBQVG0GeF2iSHZ9jNlnE+zDmSur92nqJlK0C8TC95MrY/xGn/f+
 RLeAkT99XzGBBti4ytrVh2kgSb1YAdzA7kVcFIUt8=
X-Received: by 2002:a05:600c:860b:b0:490:7df7:9190 with SMTP id
 5b1f17b1804b1-4907df7925bmr62138995e9.8.1779888986408; 
 Wed, 27 May 2026 06:36:26 -0700 (PDT)
X-Received: by 2002:a05:600c:860b:b0:490:7df7:9190 with SMTP id
 5b1f17b1804b1-4907df7925bmr62138065e9.8.1779888985725; 
 Wed, 27 May 2026 06:36:25 -0700 (PDT)
Received: from [192.168.103.110]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045282201sm441094355e9.8.2026.05.27.06.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 06:36:25 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <ed2a7ea2-51c6-4503-bcd8-efa72337af85@gmx.de>
Date: Wed, 27 May 2026 15:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: mtd: Add tests for mtd command
To: Love Kumar <love.kumar@amd.com>
References: <20260526073749.89059-1-love.kumar@amd.com>
Content-Language: en-US
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, michal.simek@amd.com,
 git@amd.com, trini@konsulko.com, sjg@chromium.org
In-Reply-To: <20260526073749.89059-1-love.kumar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/26/26 09:37, Love Kumar wrote:
> Add test cases for mtd commands to verify list, erase, write, read
> and dump operations on NOR flash and binary-file data integrity.
> This test relies on boardenv_* configurations to run it for single or
> multiple MTD partitions.
> 
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>   doc/develop/pytest/test_mtd.rst |  10 +
>   test/py/tests/test_mtd.py       | 648 ++++++++++++++++++++++++++++++++
>   2 files changed, 658 insertions(+)
>   create mode 100644 doc/develop/pytest/test_mtd.rst
>   create mode 100644 test/py/tests/test_mtd.py
> 
> diff --git a/doc/develop/pytest/test_mtd.rst b/doc/develop/pytest/test_mtd.rst
> new file mode 100644
> index 000000000000..70d469af5caa
> --- /dev/null
> +++ b/doc/develop/pytest/test_mtd.rst
> @@ -0,0 +1,10 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +test_mtd
> +========
> +
> +.. automodule:: test_mtd
> +   :synopsis:
> +   :member-order: bysource
> +   :members:
> +   :undoc-members:
> diff --git a/test/py/tests/test_mtd.py b/test/py/tests/test_mtd.py
> new file mode 100644
> index 000000000000..947eba7426c6
> --- /dev/null
> +++ b/test/py/tests/test_mtd.py
> @@ -0,0 +1,648 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# (C) Copyright 2026, Advanced Micro Devices, Inc.
> +
> +"""
> +Note: This test relies on boardenv_* containing configuration values to
> +define one or more MTD partitions on which to exercise the 'mtd' U-Boot
> +command. The test reads env__mtd_partitions itself and loops over every
> +entry. Without this configuration the test is automatically skipped.
> +
> +It exercises the 'mtd' subcommands (list, erase, write, read, dump) and
> +a binary-file data integrity round-trip (tftp + write + read + cmp.b).
> +The suite works for single and stacked flash configurations. Partitions
> +whose detected MTD type is not 'NOR flash' are logged and skipped
> +per-partition.
> +
> +For Example:
> +
> +# List of MTD partitions to test. partition_name is the MTD partition
> +# name passed to every 'mtd' subcommand; flash_part_name is optional
> +# and, when set, is verified against 'SF: Detected <name>' lines in
> +# 'mtd list' output.
> +#
> +# partition_name      - MTD partition name (required)
> +# flash_part_name     - expected flash chip name (optional)
> +# expected_size       - partition size in bytes (optional cross-check)
> +# expected_erasesize  - erase-block size in bytes (optional cross-check)
> +# writeable           - bool; if False only non-destructive tests run
> +# timeout             - per-partition command timeout for long ops
> +env__mtd_partitions = [
> +    {
> +        'partition_name': 'qspi-fsbl-uboot',
> +        'flash_part_name': 'mt25qu512a',
> +        'expected_size': 0x1000000,
> +        'expected_erasesize': 0x10000,
> +        'writeable': True,
> +    },
> +    {
> +        'partition_name': 'rootfs_b',
> +        'flash_part_name': 'mt25qu512a',
> +        'expected_size': 0x1000000,
> +        'writeable': True,
> +    },
> +    {
> +        'partition_name': 'rootfs_a-rootfs_c-concat',
> +        'flash_part_name': 'mt25qu512a',
> +        'expected_size': 0x6000000,
> +        'writeable': True,
> +    },
> +]
> +
> +# Binary-file data integrity test configuration. When set,
> +# test_mtd_bin_integrity fetches the file over TFTP once, then writes
> +# it to every writeable partition large enough to hold it and verifies
> +# byte-for-byte equality via 'cmp.b'. When unset, that test is skipped.
> +#
> +# bin_file      - TFTP filename of the binary blob
> +# bin_size      - byte size of the binary blob
> +# tftp_addr     - RAM address used as the TFTP destination and source
> +#                 for 'mtd write'
> +# readback_addr - RAM address used to read the data back from flash
> +env__mtd_bin_test = {
> +    'bin_file': 'BOOT_SINGLE.BIN',
> +    'tftp_addr': 0x200000,
> +    'bin_size': 0x1E3300,
> +    'readback_addr': 0x5000000,
> +}
> +
> +# Optional. If omitted, tests use the defaults shown below.
> +#   iteration       - randomized iteration count per test (default 3)
> +#   default_timeout - default per-command timeout in milliseconds
> +#                     (default 1000000)
> +env__mtd_test_settings = {
> +    'iteration': 3,
> +    'default_timeout': 1000000,
> +}
> +"""

Hello Love,

make htmldocs

fails with your patch:

/test/py/tests/test_mtd.py:docstring of test_mtd:26: ERROR: Unexpected 
indentation. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:32: WARNING: Definition 
list ends without a blank line; unexpected unindent. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:34: ERROR: Unexpected 
indentation. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:38: WARNING: Block 
quote ends without a blank line; unexpected unindent. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:40: ERROR: Unexpected 
indentation. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:44: WARNING: Block 
quote ends without a blank line; unexpected unindent. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:45: WARNING: Block 
quote ends without a blank line; unexpected unindent. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:58: ERROR: Unexpected 
indentation. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:62: WARNING: Block 
quote ends without a blank line; unexpected unindent. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:69: ERROR: Unexpected 
indentation. [docutils]
/test/py/tests/test_mtd.py:docstring of test_mtd:71: WARNING: Block 
quote ends without a blank line; unexpected unindent. [docutils]

The suggestion below fixes the issue.

Best regards

Heinrich

# SPDX-License-Identifier: GPL-2.0
# (C) Copyright 2026, Advanced Micro Devices, Inc.

"""

This test relies on boardenv_* containing configuration values to
define one or more MTD partitions on which to exercise the 'mtd' U-Boot
command. The test reads env__mtd_partitions itself and loops over every
entry. Without this configuration the test is automatically skipped.

It exercises the 'mtd' subcommands (list, erase, write, read, dump) and
a binary-file data integrity round-trip (tftp + write + read + cmp.b).
The suite works for single and stacked flash configurations. Partitions
whose detected MTD type is not 'NOR flash' are logged and skipped
per-partition.

For Example:

.. code-block:: python

     # List of MTD partitions to test. partition_name is the MTD partition
     # name passed to every 'mtd' subcommand; flash_part_name is optional
     # and, when set, is verified against 'SF: Detected <name>' lines in
     # 'mtd list' output.
     #
     # partition_name      - MTD partition name (required)
     # flash_part_name     - expected flash chip name (optional)
     # expected_size       - partition size in bytes (optional cross-check)
     # expected_erasesize  - erase-block size in bytes (optional 
cross-check)
     # writeable           - bool; if False only non-destructive tests run
     # timeout             - per-partition command timeout for long ops
     env__mtd_partitions = [
         {
             'partition_name': 'qspi-fsbl-uboot',
             'flash_part_name': 'mt25qu512a',
             'expected_size': 0x1000000,
             'expected_erasesize': 0x10000,
             'writeable': True,
         },
         {
             'partition_name': 'rootfs_b',
             'flash_part_name': 'mt25qu512a',
             'expected_size': 0x1000000,
             'writeable': True,
         },
         {
             'partition_name': 'rootfs_a-rootfs_c-concat',
             'flash_part_name': 'mt25qu512a',
             'expected_size': 0x6000000,
             'writeable': True,
         },
     ]

     # Binary-file data integrity test configuration. When set,
     # test_mtd_bin_integrity fetches the file over TFTP once, then writes
     # it to every writeable partition large enough to hold it and verifies
     # byte-for-byte equality via 'cmp.b'. When unset, that test is skipped.
     #
     # bin_file      - TFTP filename of the binary blob
     # bin_size      - byte size of the binary blob
     # tftp_addr     - RAM address used as the TFTP destination and source
     #                 for 'mtd write'
     # readback_addr - RAM address used to read the data back from flash
     env__mtd_bin_test = {
         'bin_file': 'BOOT_SINGLE.BIN',
         'tftp_addr': 0x200000,
         'bin_size': 0x1E3300,
         'readback_addr': 0x5000000,
     }

     # Optional. If omitted, tests use the defaults shown below.
     #   iteration       - randomized iteration count per test (default 3)
     #   default_timeout - default per-command timeout in milliseconds
     #                     (default 1000000)
     env__mtd_test_settings = {
         'iteration': 3,
         'default_timeout': 1000000,
     }
"""


> +
> +import random
> +import re
> +import pytest
> +import test_net
> +import utils
> +
> +MTD_LIST_HEADER = 'List of MTD devices:'
> +SF_DETECTED = 'SF: Detected'
> +SUPPORTED_TYPE = 'NOR flash'
> +EXPECTED_ERASE = 'eraseblock(s)'
> +EXPECTED_WRITE = 'Writing'
> +WRITE_FAILURE = 'Failure while writing'
> +EXPECTED_READ = 'Reading'
> +READ_FAILURE = 'Failure while reading'
> +EXPECTED_DUMP = 'Dump'
> +EXPECTED_COMPARE = 'were the same'
> +TFTP_DONE = 'Bytes transferred = '
> +
> +DEFAULT_TIMEOUT = 1000000
> +DEFAULT_ITERATION = 3
> +
> +def parse_mtd_list(output):
> +    """Parse 'mtd list' output into a dict keyed by device name.
> +
> +    Each value has 'type', 'block_size', 'min_io' and a 'partitions'
> +    dict mapping name -> (start, end) for the device-level span and
> +    any nested partition lines.
> +    """
> +    devices = {}
> +    current = None
> +    for line in output.splitlines():
> +        match = re.match(r'^\* (\S+)\s*$', line)
> +        if match:
> +            current = match.group(1)
> +            devices[current] = {
> +                'type': None,
> +                'block_size': 0,
> +                'min_io': 0,
> +                'partitions': {},
> +            }
> +            continue
> +        if current is None:
> +            continue
> +        match = re.match(r'^\s*- type: (.+?)\s*$', line)
> +        if match:
> +            devices[current]['type'] = match.group(1)
> +            continue
> +        match = re.match(r'^\s*- block size: (0x[0-9a-f]+) bytes\s*$', line)
> +        if match:
> +            devices[current]['block_size'] = int(match.group(1), 16)
> +            continue
> +        match = re.match(r'^\s*- min I/O: (0x[0-9a-f]+) bytes\s*$', line)
> +        if match:
> +            devices[current]['min_io'] = int(match.group(1), 16)
> +            continue
> +        match = re.search(r'0x([0-9a-f]+)-0x([0-9a-f]+) : "([^"]+)"', line)
> +        if match:
> +            start = int(match.group(1), 16)
> +            end = int(match.group(2), 16)
> +            name = match.group(3)
> +            devices[current]['partitions'][name] = (start, end)
> +    return devices
> +
> +def parse_flash_parts(output):
> +    """Return the list of flash names from 'SF: Detected <name>' lines."""
> +    return re.findall(rf'{SF_DETECTED} (\S+) with', output)
> +
> +def find_part_info(parsed, partition_name):
> +    """Look up a partition across all parsed devices.
> +
> +    Returns (dev_info, start, end) or (None, None, None) if not found.
> +    """
> +    for dev_info in parsed.values():
> +        if partition_name in dev_info['partitions']:
> +            start, end = dev_info['partitions'][partition_name]
> +            return dev_info, start, end
> +    return None, None, None
> +
> +def get_iterations(ubman):
> +    """Per-test iteration count from env__mtd_test_settings (default 3)."""
> +    settings = ubman.config.env.get('env__mtd_test_settings', {})
> +    return settings.get('iteration', DEFAULT_ITERATION)
> +
> +def get_default_timeout(ubman):
> +    """Default command timeout in ms from env__mtd_test_settings.
> +
> +    Defaults to DEFAULT_TIMEOUT (1000000) if unset.
> +    """
> +    settings = ubman.config.env.get('env__mtd_test_settings', {})
> +    return settings.get('default_timeout', DEFAULT_TIMEOUT)
> +
> +def mtd_prepare(ubman, config):
> +    """Probe an MTD partition and return a parameter dict.
> +
> +    Returns None (after logging via ubman.log.info) if the partition
> +    is not present or its detected type is not 'NOR flash'. A missing
> +    partition_name in the config triggers pytest.fail.
> +    """
> +    partition_name = config.get('partition_name')
> +    if not partition_name:
> +        pytest.fail(
> +            "env__mtd_partitions entry missing required key "
> +            "'partition_name'"
> +        )
> +
> +    output = do_list(ubman)
> +    parsed = parse_mtd_list(output)
> +    if not parsed:
> +        pytest.fail(f'mtd list returned no devices; output was:\n{output}')
> +
> +    dev_info, start, end = find_part_info(parsed, partition_name)
> +    if dev_info is None:
> +        ubman.log.info(f'skip {partition_name!r}: not present in mtd list')
> +        return None
> +
> +    mtd_type = dev_info['type']
> +    if mtd_type != SUPPORTED_TYPE:
> +        ubman.log.info(
> +            f'skip {partition_name!r}: type {mtd_type!r} unsupported '
> +            f'(only {SUPPORTED_TYPE!r} is supported)'
> +        )
> +        return None
> +
> +    size = end - start
> +    erasesize = dev_info['block_size']
> +    writesize = dev_info['min_io']
> +    if erasesize == 0 or writesize == 0:
> +        pytest.fail(
> +            f'mtd list reported invalid geometry for {partition_name!r}: '
> +            f'erasesize={erasesize:#x} writesize={writesize:#x}'
> +        )
> +
> +    expected_size = config.get('expected_size')
> +    if expected_size and expected_size != size:
> +        pytest.fail(
> +            f'Size mismatch for {partition_name!r}: expected '
> +            f'{expected_size:#x}, got {size:#x}'
> +        )
> +    expected_erasesize = config.get('expected_erasesize')
> +    if expected_erasesize and expected_erasesize != erasesize:
> +        pytest.fail(
> +            f'Erase size mismatch for {partition_name!r}: expected '
> +            f'{expected_erasesize:#x}, got {erasesize:#x}'
> +        )
> +
> +    return {
> +        'name': partition_name,
> +        'size': size,
> +        'start': start,
> +        'erasesize': erasesize,
> +        'writesize': writesize,
> +        'type': mtd_type,
> +        'ram_base': utils.find_ram_base(ubman),
> +        'timeout': config.get('timeout', get_default_timeout(ubman)),
> +        'writeable': config.get('writeable', False),
> +        'flash_part_name': config.get('flash_part_name'),
> +    }
> +
> +def rand_aligned_offset(size, align):
> +    """Random offset that is a multiple of 'align' inside [0, size-align]."""
> +    if size <= align:
> +        return 0
> +    return random.randrange(0, size - align + 1, align)
> +
> +def rand_aligned_range(part, kind):
> +    """Random aligned (offset, length) inside the partition.
> +
> +    kind is 'erase' (erase-block aligned) or 'io' (page aligned). The
> +    caller must have verified the partition holds at least one unit.
> +    """
> +    if kind == 'erase':
> +        align = part['erasesize']
> +    elif kind == 'io':
> +        align = max(part['writesize'], 1)
> +    else:
> +        raise ValueError(f'Unknown alignment kind: {kind!r}')
> +
> +    size = part['size']
> +    off = rand_aligned_offset(size, align)
> +    remaining = size - off
> +    if remaining <= align:
> +        length = align
> +    else:
> +        length = random.randrange(align, remaining + 1, align)
> +    return off, length
> +
> +def run_op(ubman, part, cmd, exp_str=None, not_exp_str=None, exp_rc=0):
> +    """Run a U-Boot command and check its output and return code.
> +
> +    exp_str / not_exp_str (when not None) must / must not appear in the
> +    output. exp_rc is the expected echo $? value; pass -1 to skip the
> +    rc check. 'part' provides the timeout; pass None to use the default.
> +    Returns (output, rc_string).
> +    """
> +    timeout = part['timeout'] if part else DEFAULT_TIMEOUT
> +    with ubman.temporary_timeout(timeout):
> +        output = ubman.run_command(cmd)
> +    if exp_str is not None:
> +        assert exp_str in output, (
> +            f'Expected {exp_str!r} in output of {cmd!r}, got:\n{output}'
> +        )
> +    if not_exp_str is not None:
> +        assert not_exp_str not in output, (
> +            f'Unexpected {not_exp_str!r} in output of {cmd!r}'
> +        )
> +    rc_str = ubman.run_command('echo $?')
> +    if exp_rc >= 0:
> +        assert rc_str.endswith(str(exp_rc)), (
> +            f'Expected rc {exp_rc} for {cmd!r}, got {rc_str!r}'
> +        )
> +    return output, rc_str
> +
> +def do_list(ubman):
> +    """Run 'mtd list' and return the raw output."""
> +    timeout = get_default_timeout(ubman)
> +    with ubman.temporary_timeout(timeout):
> +        output = ubman.run_command('mtd list')
> +    assert MTD_LIST_HEADER in output, (
> +        f'Expected {MTD_LIST_HEADER!r} in mtd list output, got:\n{output}'
> +    )
> +    return output
> +
> +def do_erase(ubman, part, off, size, exp_rc=0):
> +    """Run 'mtd erase <name> <off> <size>'. off/size must be aligned."""
> +    cmd = f'mtd erase {part["name"]} {off:#x} {size:#x}'
> +    exp = EXPECTED_ERASE if exp_rc == 0 else None
> +    return run_op(ubman, part, cmd, exp_str=exp, exp_rc=exp_rc)
> +
> +def do_write(ubman, part, addr, off, size, exp_rc=0):
> +    """Run 'mtd write <name> <addr> <off> <size>'."""
> +    cmd = f'mtd write {part["name"]} {addr:#x} {off:#x} {size:#x}'
> +    exp = EXPECTED_WRITE if exp_rc == 0 else None
> +    not_exp = WRITE_FAILURE if exp_rc == 0 else None
> +    return run_op(
> +        ubman, part, cmd, exp_str=exp, not_exp_str=not_exp, exp_rc=exp_rc,
> +    )
> +
> +def do_read(ubman, part, addr, off, size, exp_rc=0):
> +    """Run 'mtd read <name> <addr> <off> <size>'."""
> +    cmd = f'mtd read {part["name"]} {addr:#x} {off:#x} {size:#x}'
> +    exp = EXPECTED_READ if exp_rc == 0 else None
> +    not_exp = READ_FAILURE if exp_rc == 0 else None
> +    return run_op(
> +        ubman, part, cmd, exp_str=exp, not_exp_str=not_exp, exp_rc=exp_rc,
> +    )
> +
> +def do_dump(ubman, part, off=None, size=None):
> +    """Run 'mtd dump' and verify a hex dump line is produced."""
> +    cmd = f'mtd dump {part["name"]}'
> +    if off is not None:
> +        cmd += f' {off:#x}'
> +        if size is not None:
> +            cmd += f' {size:#x}'
> +    output, _ = run_op(ubman, part, cmd, exp_str=EXPECTED_DUMP)
> +    assert re.search(
> +        r'0x[0-9a-f]{8}:\s+(?:[0-9a-f]{2}\s+){8,}', output
> +    ), (
> +        f'Expected hex dump line, got:\n{output}'
> +    )
> +    return output
> +
> +def round_trip_verify(ubman, part, off, size, pattern=None):
> +    """Erase, write a RAM pattern, read it back, and CRC-compare.
> +
> +    The source pattern goes to part['ram_base'] and the readback area
> +    is part['ram_base'] + part['size'] so the two never overlap. Both
> +    off and size must be erase-block aligned. Returns the source CRC.
> +    """
> +    src = part['ram_base']
> +    dst = part['ram_base'] + part['size']
> +    if pattern is None:
> +        pattern = random.randint(1, 0xfe)
> +    ubman.run_command(f'mw.b {src:#x} {pattern:#x} {size:#x}')
> +    src_crc = utils.crc32(ubman, src, size)
> +    do_erase(ubman, part, off, size)
> +    do_write(ubman, part, src, off, size)
> +    do_read(ubman, part, dst, off, size)
> +    dst_crc = utils.crc32(ubman, dst, size)
> +    assert src_crc == dst_crc, (
> +        f'CRC mismatch after round-trip on {part["name"]!r}: '
> +        f'src={src_crc} dst={dst_crc} off={off:#x} size={size:#x}'
> +    )
> +    return src_crc
> +
> +def setup_network(ubman):
> +    """Bring up the network (try DHCP, fall back to static), or skip."""
> +    test_net.test_net_dhcp(ubman)
> +    if not test_net.net_set_up:
> +        test_net.test_net_setup_static(ubman)
> +    if not test_net.net_set_up:
> +        pytest.skip('Network setup failed; cannot fetch binary file')
> +
> +def get_configs(ubman):
> +    """Return env__mtd_partitions or skip the test if not configured."""
> +    configs = ubman.config.env.get('env__mtd_partitions', None)
> +    if not configs:
> +        pytest.skip('No MTD partitions configured')
> +    return configs
> +
> +@pytest.mark.buildconfigspec('cmd_mtd')
> +def test_mtd_list(ubman):
> +    """Verify 'mtd list' shows every partition and expected flash part."""
> +    configs = get_configs(ubman)
> +    output = do_list(ubman)
> +    parsed = parse_mtd_list(output)
> +    detected_flash = parse_flash_parts(output)
> +
> +    for config in configs:
> +        partition_name = config.get('partition_name')
> +        if not partition_name:
> +            pytest.fail(
> +                "env__mtd_partitions entry missing 'partition_name'"
> +            )
> +        dev_info, start, end = find_part_info(parsed, partition_name)
> +        assert dev_info is not None, (
> +            f'Partition {partition_name!r} not in mtd list output:\n'
> +            f'{output}'
> +        )
> +        expected_erasesize = config.get('expected_erasesize')
> +        if expected_erasesize:
> +            assert dev_info['block_size'] == expected_erasesize, (
> +                f'Erase size mismatch for {partition_name!r}: '
> +                f'expected {expected_erasesize:#x}, got '
> +                f'{dev_info["block_size"]:#x}'
> +            )
> +        expected_size = config.get('expected_size')
> +        if expected_size:
> +            assert (end - start) == expected_size, (
> +                f'Size mismatch for {partition_name!r}: expected '
> +                f'{expected_size:#x}, got {end - start:#x}'
> +            )
> +        flash_part_name = config.get('flash_part_name')
> +        if flash_part_name:
> +            assert flash_part_name in detected_flash, (
> +                f'Expected flash part {flash_part_name!r} not found '
> +                f'in SF: Detected lines: {detected_flash}'
> +            )
> +
> +@pytest.mark.buildconfigspec('cmd_mtd')
> +@pytest.mark.buildconfigspec('cmd_bdi')
> +def test_mtd_erase_block(ubman):
> +    """Erase random aligned ranges in every writeable partition."""
> +    configs = get_configs(ubman)
> +    ran_any = False
> +    for config in configs:
> +        part = mtd_prepare(ubman, config)
> +        if part is None:
> +            continue
> +        if not part['writeable']:
> +            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
> +            continue
> +        if part['size'] < part['erasesize']:
> +            ubman.log.info(
> +                f'skip {part["name"]!r}: smaller than one erase block'
> +            )
> +            continue
> +        for _ in range(get_iterations(ubman)):
> +            off, size = rand_aligned_range(part, 'erase')
> +            do_erase(ubman, part, off, size)
> +        ran_any = True
> +    if not ran_any:
> +        pytest.skip('No writeable partition large enough for this test')
> +
> +@pytest.mark.buildconfigspec('cmd_mtd')
> +def test_mtd_erase_all(ubman):
> +    """Erase every writeable partition in full."""
> +    configs = get_configs(ubman)
> +    ran_any = False
> +    for config in configs:
> +        part = mtd_prepare(ubman, config)
> +        if part is None:
> +            continue
> +        if not part['writeable']:
> +            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
> +            continue
> +        if part['size'] < part['erasesize']:
> +            ubman.log.info(
> +                f'skip {part["name"]!r}: smaller than one erase block'
> +            )
> +            continue
> +        # Round down to whole erase blocks: partition size is not
> +        # guaranteed to be a multiple of the erase block.
> +        full = (part['size'] // part['erasesize']) * part['erasesize']
> +        for _ in range(get_iterations(ubman)):
> +            do_erase(ubman, part, 0, full)
> +        ran_any = True
> +    if not ran_any:
> +        pytest.skip('No writeable partition large enough for this test')
> +
> +@pytest.mark.buildconfigspec('cmd_mtd')
> +@pytest.mark.buildconfigspec('cmd_bdi')
> +@pytest.mark.buildconfigspec('cmd_memory')
> +@pytest.mark.buildconfigspec('cmd_crc32')
> +def test_mtd_write_read_random(ubman):
> +    """Round-trip a random pattern at random aligned ranges."""
> +    configs = get_configs(ubman)
> +    ran_any = False
> +    for config in configs:
> +        part = mtd_prepare(ubman, config)
> +        if part is None:
> +            continue
> +        if not part['writeable']:
> +            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
> +            continue
> +        if part['size'] < part['erasesize']:
> +            ubman.log.info(
> +                f'skip {part["name"]!r}: smaller than one erase block'
> +            )
> +            continue
> +        for _ in range(get_iterations(ubman)):
> +            off, size = rand_aligned_range(part, 'erase')
> +            round_trip_verify(ubman, part, off, size)
> +        ran_any = True
> +    if not ran_any:
> +        pytest.skip('No writeable partition large enough for this test')
> +
> +@pytest.mark.buildconfigspec('cmd_mtd')
> +@pytest.mark.buildconfigspec('cmd_bdi')
> +@pytest.mark.buildconfigspec('cmd_memory')
> +@pytest.mark.buildconfigspec('cmd_crc32')
> +def test_mtd_write_twice(ubman):
> +    """Round-trip small, medium, full, and a partition-midpoint write."""
> +    configs = get_configs(ubman)
> +    ran_any = False
> +    for config in configs:
> +        part = mtd_prepare(ubman, config)
> +        if part is None:
> +            continue
> +        if not part['writeable']:
> +            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
> +            continue
> +        if part['size'] < part['erasesize']:
> +            ubman.log.info(
> +                f'skip {part["name"]!r}: smaller than one erase block'
> +            )
> +            continue
> +        erasesize = part['erasesize']
> +        full = (part['size'] // erasesize) * erasesize
> +        mid_upper = max(erasesize + 1, full // 2)
> +        sizes = [
> +            erasesize,
> +            random.randrange(erasesize, mid_upper + 1, erasesize),
> +            full,
> +        ]
> +        for chunk in sizes:
> +            round_trip_verify(ubman, part, 0, chunk)
> +
> +        # Write a short region centred on the partition midpoint. For
> +        # concat partitions this straddles the inner boundary.
> +        op_size = min(erasesize * 4, full)
> +        op_size = (op_size // erasesize) * erasesize
> +        half = (op_size // 2 // erasesize) * erasesize
> +        if half == 0:
> +            half = erasesize
> +        midpoint = (full // 2 // erasesize) * erasesize
> +        straddle_off = max(midpoint - half, 0)
> +        if op_size >= erasesize and straddle_off + op_size <= full:
> +            round_trip_verify(ubman, part, straddle_off, op_size)
> +        ran_any = True
> +    if not ran_any:
> +        pytest.skip('No writeable partition large enough for this test')
> +
> +@pytest.mark.buildconfigspec('cmd_mtd')
> +def test_mtd_dump(ubman):
> +    """Verify 'mtd dump' produces a hex dump (default + explicit size)."""
> +    configs = get_configs(ubman)
> +    ran_any = False
> +    for config in configs:
> +        part = mtd_prepare(ubman, config)
> +        if part is None:
> +            continue
> +        align = max(part['writesize'], 1)
> +        units_total = part['size'] // align
> +        if units_total == 0:
> +            ubman.log.info(
> +                f'skip {part["name"]!r}: smaller than one I/O unit'
> +            )
> +            continue
> +
> +        # Default-size dump: writesize bytes from a random aligned
> +        # offset.
> +        off = rand_aligned_offset(part['size'], align)
> +        do_dump(ubman, part, off=off)
> +
> +        # Explicit-size dump: 1..4 aligned units, with the offset
> +        # picked after the size so off + size stays within the
> +        # partition.
> +        units = random.randint(1, min(4, units_total))
> +        size = units * align
> +        off = random.randint(0, units_total - units) * align
> +        do_dump(ubman, part, off=off, size=size)
> +        ran_any = True
> +    if not ran_any:
> +        pytest.skip('No partition available for dump')
> +
> +@pytest.mark.buildconfigspec('cmd_mtd')
> +@pytest.mark.buildconfigspec('cmd_bdi')
> +@pytest.mark.buildconfigspec('cmd_memory')
> +@pytest.mark.buildconfigspec('net_legacy', 'net_lwip')
> +def test_mtd_bin_integrity(ubman):
> +    """Write a binary blob to flash and byte-compare it back.
> +
> +    Fetches the binary over TFTP once, then writes it to every
> +    writeable partition that is large enough to hold it. Each write
> +    is followed by reading the data back into a different RAM region
> +    and comparing byte-for-byte via 'cmp.b'.
> +    """
> +    bin_cfg = ubman.config.env.get('env__mtd_bin_test')
> +    if not bin_cfg:
> +        pytest.skip('No env__mtd_bin_test configured')
> +    configs = get_configs(ubman)
> +
> +    bin_file = bin_cfg.get('bin_file')
> +    bin_size = bin_cfg.get('bin_size')
> +    tftp_addr = bin_cfg.get('tftp_addr')
> +    readback_addr = bin_cfg.get('readback_addr')
> +    missing = [
> +        key for key, val in (
> +            ('bin_file', bin_file),
> +            ('bin_size', bin_size),
> +            ('tftp_addr', tftp_addr),
> +            ('readback_addr', readback_addr),
> +        ) if val is None
> +    ]
> +    if missing:
> +        pytest.fail(f'env__mtd_bin_test missing required keys: {missing}')
> +
> +    setup_network(ubman)
> +    cmd = f'tftpb {tftp_addr:#x} {bin_file}'
> +    with ubman.temporary_timeout(get_default_timeout(ubman)):
> +        output = ubman.run_command(cmd)
> +    if 'TIMEOUT' in output:
> +        pytest.fail(f'TFTP timed out fetching {bin_file!r}')
> +    if TFTP_DONE not in output:
> +        pytest.fail(
> +            f'TFTP of {bin_file!r} did not complete, output:\n{output}'
> +        )
> +
> +    ran_any = False
> +    for config in configs:
> +        part = mtd_prepare(ubman, config)
> +        if part is None:
> +            continue
> +        if not part['writeable']:
> +            ubman.log.info(f'skip {part["name"]!r}: not marked writeable')
> +            continue
> +        erasesize = part['erasesize']
> +        erase_size = ((bin_size + erasesize - 1) // erasesize) * erasesize
> +        if erase_size > part['size']:
> +            ubman.log.info(
> +                f'skip {part["name"]!r}: binary ({bin_size:#x}) does '
> +                f'not fit in partition ({part["size"]:#x})'
> +            )
> +            continue
> +
> +        do_erase(ubman, part, 0, erase_size)
> +        do_write(ubman, part, tftp_addr, 0, bin_size)
> +        # Wipe the readback area so a stale match cannot pass as success.
> +        ubman.run_command(f'mw.b {readback_addr:#x} 0x00 {bin_size:#x}')
> +        do_read(ubman, part, readback_addr, 0, bin_size)
> +        cmp_cmd = f'cmp.b {tftp_addr:#x} {readback_addr:#x} {bin_size:#x}'
> +        cmp_out = ubman.run_command(cmp_cmd)
> +        assert EXPECTED_COMPARE in cmp_out, (
> +            f'Binary mismatch on {part["name"]!r}: cmp.b reported '
> +            f'{cmp_out!r}'
> +        )
> +        ran_any = True
> +    if not ran_any:
> +        pytest.skip(
> +            'No writeable partition large enough for the binary file'
> +        )

