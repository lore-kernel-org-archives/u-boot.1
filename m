Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11217CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 20:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 622C68465D;
	Sun, 17 May 2026 22:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="HlOLKGke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FF48465D; Sun, 17 May 2026 22:49:32 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDACF845E3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 22:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:2af:22b0:dca3:1ad8:a26:89cb])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 0A435B00565;
 Sun, 17 May 2026 22:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1779050969;
 bh=7zjX2bnMtuenRFQN4kN+eMDOIFJgAa0f0ORlDLoBE1g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HlOLKGkecuWeqfd04o/PVZc5WH8ub7voYIFptGEYVO88yZYXCFjb0MnxMko6rEsmA
 uvaUnKBibYk4kwV+JDgVpJAEp89oJGwu2lZCgg1YE2m3PBzY7DAQbgjf9Td5jTOlTX
 OBarwiU/JzZRZlPacoPhZlRhPHpwi0yOEsNHCjA1MBIIgHNFlAHJXJenMQUsUHeyNg
 itLP5rhZdOVyZcGBPV6mQASrEYcQBFIJGAtEa8uBlvTnYONII8j67lDkKCfBb73LZT
 e/rAK9JoZhXLX27PgN5fhjqh+Fr6nUar6bGNeDWuHfTxifd0fU14VyAJdWX6L7kGhu
 KhVpLGy+lIoIg==
Date: Sun, 17 May 2026 22:49:18 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v1] fs: dispatch null_dev_desc_ok filesystems before
 block lookup
Message-ID: <agopzp-8nFc7W8xU@L30177.local>
References: <20260511115340.675883-1-vjardin@free.fr>
 <CAFLszTj40xCsVeVMxCCCHAx=N16-LL48OJ4_M_tja1ka48vCrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTj40xCsVeVMxCCCHAx=N16-LL48OJ4_M_tja1ka48vCrA@mail.gmail.com>
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

Hi Simon,

Thanks. See below,

Before I send v2, I'd like your feedbacks,

Le 15/05/26 06:43, Simon Glass a écrit :
> 1. Typo: 'thue' should be 'the'

ok for v2

> 2. If cmd/ubifs.c is the duplication this patch obsoletes, please
> either remove it in the same series or reword the motivation - as it
> stands the duplication is still in-tree after the patch, so the reader
> is left wondering whether 'load ubifs ...' is now the preferred entry
> point or whether ubifsload remains supported

I'll reword in v2's commit body. The point of this
patch is to make load ubifs <addr> <file> a first-class entry
point that routes through fs_set_blk_dev() like every other
fstype. ubifsload (cmd/ubifs.c) stays in-tree for backward
compatibility; removing (or change it to a preferred entry),
it is not the goal of this commit, but it seems to be a quick win.

> 
> Please also spell out which user-visible commands get this new support
> ('load semihosting ...', 'load ubifs ...').

ok, v2's commit log will show them, per the following.
For instance, based on my records from today,

My board: NXP LX2160A, U-Boot 2026.04-00933-g0a14371fb76c with
OpenOCD attached using J-Link for SYS_OPEN / SYS_READ / SYS_FLEN / SYS_CLOSE from
the host filesystem,

load semihosting

    => load semihosting - 0xc0000000 semihost-test.txt
    76 bytes read in 835 ms (0 Bytes/s)
    => md.b 0xc0000000 80
    c0000000: 53 65 6d 69 68 6f 73 74 69 6e 67 20 74 65 73 74  Semihosting test
    c0000010: 20 66 69 6c 65 20 66 72 6f 6d 20 55 2d 42 6f 6f   file from U-Boo
    c0000020: 74 20 70 61 74 63 68 20 76 65 72 69 66 69 63 61  t patch verifica
    c0000030: 74 69 6f 6e 20 2d 20 32 30 32 36 2d 30 35 2d 31  tion - 2026-05-1
    c0000040: 37 54 31 35 3a 31 38 3a 34 33 5a 0a ef be ad de  7T15:18:43Z.....

size semihosting

    => size semihosting - semihost-test.txt
    => printenv filesize
    filesize=4c

    # OpenOCD debug logs
    semihosting_common(): op=0x1 (OPEN), param=0xfbb37fe8
    semihosting_common(): open('/tmp/semihost-test.txt')=12
    semihosting_common(): op=0xc (FLEN), param=0xfbb37ff8
    semihosting_common(): op=0x2 (CLOSE), param=0xfbb37ff8

ls semihosting : fs/semihostingfs.c does not registers ls hook in its
fstype_info, so fs_ls() has no work to do. OpenOCD's
log confirms no semihosting transaction was issued during
the ls attempts, as expected:

    => ls semihosting - .
    => ls semihosting - semihost-test.txt
    (silent return, no error, no semihosting trap fired)

Without this patch all those commands fail in fs_set_blk_dev()
with
  ** Bad device specification semihosting **
before the FS layer is called.

For ubifs, it is code analysis only, I do not have hardware boards
to check.

From the code review:

  - fs/ubifs/ubifs.c:ubifs_set_blk_dev() takes (struct blk_desc *,
    struct disk_partition *) and ignores both, it only checks the
    global ubifs_mounted.

  - The patched fs_set_blk_dev() dispatch path, for any fstype
    whose null_dev_desc_ok flag is set, therefore feeds
    ubifs_set_blk_dev() the NULLs it has been receiving
    from cmd/ubifs.c all along. No new control flow through
    fs/ubifs/ ; the patch only adds a second entry point with
    identical preconditions.

Do you agree ?

The intended behaviour is that after ubi part ... + ubifsmount ...
have attached and mounted a volume,
  load ubifs <addr> <file> and
  ls ubifs <path>
shall work like every other <fstype> family.

I found those from code reviews, but it seems logic.

>> if (strcmp(info->name, ifname) != 0)
> if (strcmp(...)) 

I'll change to if (!strcmp(...)) in v2.

> Can you add a test for this, that loads via the new semihosting
> ifname? Do we need a doc/ update?

OK, for v2, I'll check to add both:

 - test/py/tests/test_semihosting.py exercising load semihosting
   + comparing the loaded bytes via md.b against a host-staged
   fixture. Should you have some test logics, I'll appreciate, I am
   learning with uboot and uboot test frameowrk.

 - a section in doc/usage/cmd/load.rst documenting the
   ifname-routed null-block-device path and listing the fstypes
   that opts into it (semihosting, ubifs).

For ubifs, since I cannot add hardware coverage, I'll try to wire
load ubifs into test/py/tests/test_ubifs.py alongside the
existing ubifsload invocations.

> 
> BTW, what do you think of this 'desc being NULL' approach? We should
> perhaps improve it so that we can support non-block filesystems more
> generally.

You are right that the open-coded "treat NULL block_desc as the
null-device signal" reads as a bad layering.

Maybe, as an improvement fro v2: introduce a small
helper near fs_set_blk_dev_with_part() that names the convention
explicitly, so the dispatch site is one self-documenting line:

    /*
     * Some fstypes (semihosting, ubifs) have no underlying block
     * device and ignore the block_desc argument of their set_blk_dev
     * hook. The legacy commands (ubifsload, semihosting) just pass
     * NULL; for load <iface> ... to behave the
     * same, the dispatcher opts those fstypes in by name.
     */
    static const struct fstype_info *
    fs_lookup_null_dev_info(const char *ifname)
    {
            const struct fstype_info *info = fs_get_info_by_ifname(ifname);

            return (info && info->null_dev_desc_ok) ? info : NULL;
    }

...then the dispatch:

    info = fs_lookup_null_dev_info(ifname);
    if (info)
            return info->set_blk_dev(NULL, NULL);

If you'd rather keep the dispatch open-coded with the shorter
if (!strcmp()) form you already pointed out, I'll just do that
and drop the helper; I believe it's a nice-to-have.

Your feedbacks are very welcomed and appreciated, I'll send the v2 asap.

Best regards,
  Vincent
