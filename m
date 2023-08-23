Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D87C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 23:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA0486504;
	Thu, 24 Aug 2023 01:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F8NdasXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EC8864F9; Thu, 24 Aug 2023 01:58:58 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C066846DF
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d7484cfdc11so4270126276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835134; x=1693439934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TGJsIQECFqJJZ4A0ttfPyduWxtckuON77OXhPh/h7Vc=;
 b=F8NdasXAeOCvIStcJOua9kWpU6r0IP77irCHa+jeHkIxRFbAP6uOUmU+udTulIo9Og
 x1VY/aj4SIprTk0AQvNJhoQ8PHzGdI7pTvqz4o+Q2UxEXfgVd0q0yW34cze+GoAVNjqw
 xcGTfuqCi0mdXaUn8HmQdWxvOLvibgU0mmrlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835134; x=1693439934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGJsIQECFqJJZ4A0ttfPyduWxtckuON77OXhPh/h7Vc=;
 b=iGI1h6DrpcQewIx+d6GBjf/maWr/T3+GK7Q48Fj3niKJ3/TBnTmXAd3CW0IBpynZOq
 OgdaU79H/FN9cRtJ/eCcR2FygmGxGhdxflDAVmUt23xvuwsogTc6mSilUMaJnHOoF013
 mN6t3J5DaFYQPRuyULYyFr/vUolmgcxaksIS0fQ/2lCy8rTRJUHhe6kajFERM9QTBT3R
 vewixXVF6DYa7Zk4jEd3mjGzClvIJUYLXDfUlHep3rkkw16EysxkjfFb9manKtqv/PPR
 uS6cvKZVtIoXXInYHGWswifo06MJzzfyJ43yBrx0e3QV4RBT0T47Z8b9arBYi/W3bIBp
 4Psg==
X-Gm-Message-State: AOJu0YwgSQSaodBHFITiytKOTm6g2VclodZKB2YU9thtlPxLuYTkGReL
 eEZkHX7gS01VLjpQ1vc4c5juGKEvY5J1dgGpruPHrITb9OZwtOpeiX8=
X-Google-Smtp-Source: AGHT+IHMltsyX6m6TJxdj2xk27i2/JfL61mLOGfwvvUmiOjKgB+MMOxFtGb+AJlgVLO3ksfTuZOkCjUKgcckWjA2ylE=
X-Received: by 2002:a25:a049:0:b0:d74:6c43:f32e with SMTP id
 x67-20020a25a049000000b00d746c43f32emr13034039ybh.3.1692835133771; Wed, 23
 Aug 2023 16:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-5-JPEWhacker@gmail.com>
In-Reply-To: <20230823164755.2874792-5-JPEWhacker@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:45 -0600
Message-ID: <CAPnjgZ2FV8Ous_EB8km8VHA58p+0MEaDHDfb2CGAEpzsYph4fQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] cmd: gpt: Add gpt_partition_bootable variable
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
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

Hi Joshue,

On Wed, 23 Aug 2023 at 10:48, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Adds an additional variable called gpt_partition_bootable that indicates
> if the given partition is bootable or not.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c                 |  9 +++++++--
>  doc/usage/cmd/gpt.rst     |  3 +++
>  test/py/tests/test_gpt.py | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index e6f7b0319a..7a8990e400 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -723,7 +723,7 @@ static int gpt_enumerate(struct blk_desc *desc)
>   * gpt_setenv_part_variables() - setup partition environmental variables
>   *
>   * Setup the gpt_partition_name, gpt_partition_entry, gpt_partition_addr
> - * and gpt_partition_size environment variables.
> + * and gpt_partition_size, gpt_partition_bootable environment variables.
>   *
>   * @pinfo: pointer to disk partition
>   * @i: partition entry
> @@ -750,6 +750,10 @@ static int gpt_setenv_part_variables(struct disk_partition *pinfo, int i)
>         if (ret)
>                 goto fail;
>
> +       ret = env_set_ulong("gpt_partition_bootable", !!(pinfo->bootable & PART_BOOTABLE));
> +       if (ret)
> +               goto fail;
> +
>         return 0;
>
>  fail:
> @@ -1057,7 +1061,8 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
>         " gpt setenv mmc 0 $name\n"
>         "    - setup environment variables for partition $name:\n"
>         "      gpt_partition_addr, gpt_partition_size,\n"
> -       "      gpt_partition_name, gpt_partition_entry\n"
> +       "      gpt_partition_name, gpt_partition_entry,\n"
> +       "      gpt_partition_bootable\n"

Please use single quotes except for the """ for function headers.

>         " gpt enumerate mmc 0\n"
>         "    - store list of partitions to gpt_partition_list environment variable\n"
>         " gpt guid <interface> <dev>\n"
> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> index ea2cf73a60..c9d15b2cba 100644
> --- a/doc/usage/cmd/gpt.rst
> +++ b/doc/usage/cmd/gpt.rst
> @@ -85,6 +85,7 @@ information about a particular partition. The variables are:
>  * gpt_partition_size (the size of the partition, in hexadecimal blocks)
>  * gpt_partition_name (the name of the partition)
>  * gpt_partition_entry (the partition number in the table, e.g. 1, 2, 3, etc.)
> +* gpt_partition_bootable (1 if the partition is marked as bootable, 0 if not)
>
>  To get the information about the partition named 'rootfs', issue the following
>  command:
> @@ -99,6 +100,8 @@ command:
>      rootfs
>      => echo ${gpt_partition_entry}
>      2
> +    => echo ${gpt_partition_bootable}
> +    0
>
>  The 'gpt enumerate' command will set the variable 'gpt_partition_list' with the
>  list of partition names on the device. For example:
> diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> index 339468bc12..1537ceb8c8 100644
> --- a/test/py/tests/test_gpt.py
> +++ b/test/py/tests/test_gpt.py
> @@ -49,6 +49,7 @@ class GptTestDiskImage(object):
>                  u_boot_utils.run_and_log(u_boot_console, cmd)
>                  # part1 offset 1MB size 1MB
>                  cmd = ('sgdisk', '--new=1:2048:4095', '--change-name=1:part1',
> +                    '-A 1:set:2',
>                      persistent)
>                  # part2 offset 2MB size 1.5MB
>                  u_boot_utils.run_and_log(u_boot_console, cmd)
> @@ -117,6 +118,38 @@ def test_gpt_guid(state_disk_image, u_boot_console):
>      output = u_boot_console.run_command('gpt guid host 0')
>      assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
>
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('cmd_gpt')
> +@pytest.mark.requiredtool('sgdisk')
> +def test_gpt_setenv(state_disk_image, u_boot_console):
> +    """Test the gpt setenv command."""
> +    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
> +    output = u_boot_console.run_command('gpt setenv host 0 part1')
> +    assert 'success!' in output
> +    output = u_boot_console.run_command('echo ${gpt_partition_addr}')
> +    assert output.rstrip() == '800'
> +    output = u_boot_console.run_command('echo ${gpt_partition_size}')
> +    assert output.rstrip() == '800'
> +    output = u_boot_console.run_command('echo ${gpt_partition_name}')
> +    assert output.rstrip() == 'part1'
> +    output = u_boot_console.run_command('echo ${gpt_partition_entry}')
> +    assert output.rstrip() == "1"
> +    output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
> +    assert output.rstrip() == "1"
> +
> +    output = u_boot_console.run_command('gpt setenv host 0 part2')
> +    assert 'success!' in output
> +    output = u_boot_console.run_command('echo ${gpt_partition_addr}')
> +    assert output.rstrip() == '1000'
> +    output = u_boot_console.run_command('echo ${gpt_partition_size}')
> +    assert output.rstrip() == 'c00'
> +    output = u_boot_console.run_command('echo ${gpt_partition_name}')
> +    assert output.rstrip() == 'part2'
> +    output = u_boot_console.run_command('echo ${gpt_partition_entry}')
> +    assert output.rstrip() == "2"
> +    output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
> +    assert output.rstrip() == "0"
> +
>  @pytest.mark.boardspec('sandbox')
>  @pytest.mark.buildconfigspec('cmd_gpt')
>  @pytest.mark.requiredtool('sgdisk')
> --
> 2.33.0
>

Regards,
Simon
