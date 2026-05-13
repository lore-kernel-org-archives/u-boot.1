Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE2ACD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 16:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98240836AC;
	Wed, 13 May 2026 18:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cv9PV1Nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55FF484687; Wed, 13 May 2026 18:36:34 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2AC780F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 18:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67bc6098640so11274064a12.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690191; cv=none;
 d=google.com; s=arc-20240605;
 b=BnnxwonUl/hKuDM4JjgBJJVDEot3njCSW9xBV/11mkAn5WHSxwJhTbsPzaHNBPAYGe
 PRVoG3E1cNPYZaj0tz4tOCH7eSWl1w+QIBYqNHmYHh/++nrp/UMGqtnrprWt9up/DMoA
 KMSbxN4VD1xKDvgHusIjCrLg3IqbvE8B3h/44qbINe36EwcxPRNKz0BYhdLSTOtNcexN
 pQ3bO2kUabk5CJw2AdwFU3NYkgE04P71oonBlEHH+IJ3SS9GMCgtFVF3H8iSSxnKGby/
 dxxR8yUG+d/FZ2T/N1bFbTS6B9ymkQcRjyNfzmKmzD+qmEJzARvjBqWKwRf+GfQIDERE
 c6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ntn1fcogK7HPzL+2LqSxzBlb6PbYQ7cGQotxPvIbpPk=;
 fh=S36UP7JtV5IMlwEUFm1oTxInqeniCIq9YSTehnqKNPI=;
 b=FGAW0DnQfuPHZhOqjccNVeOpbAxwtRYChbic5UBf6ilRnv2DSmR/ww2GCjHtKKhRNf
 FjTJBaKNWkQVAmmkMu5+MXFLiEvwsFYrEwTcg5KIoo9J8oKxrZsEERKqMJMnRGUbGxK6
 BdzmUe4TGVRzkJScdvThJRc/xFFrL+aIM1lAjyKqvtiSPCirH9fEktbMCI+3Xt1NznL5
 LdW9aYNZVWuIpCugbvLeyuxaGk024pSnpOLmDURJkqI5BQ/bPY2v8VViCBrK0zW4hgHB
 6pipEzBHPOZdwyxMdIUMFJ8q4oyEPbTdCjFIDlsL1Uek5wC6ckIEAaffM/kj/kJ3ECdR
 0MHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778690191; x=1779294991; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ntn1fcogK7HPzL+2LqSxzBlb6PbYQ7cGQotxPvIbpPk=;
 b=cv9PV1Nfq45R8nDZ0BawqKx1uP639k9cqnDTem9Zd77BaK2MMDwPUfTJfdfa7Xmn1M
 GSbEa3WoTXxE+AdFTVseXvsFEwq83JvXmCsYj2oqvANptaFyljofG+nFLXGXmux8UEDS
 6pcRhsQFbCD4CM9dvJ+mlML1o8ySqFyXhtAaBxn6ZHMK+Q+SUwQ7cda7hwpvSZe9cuWy
 1e4X7TUMJ6uM3I2XC0F0V3gS5RUybVlvP9YCyk7v1kGzZCdWuR5y2hS5099KlYd5Kd3o
 fyTvUDtCEhnvtAEBKZUJRvfa6nzP4QUjdxuYpIOqRL1+9kt1WcBjagjqU2JhvVf/jMnY
 CStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778690191; x=1779294991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ntn1fcogK7HPzL+2LqSxzBlb6PbYQ7cGQotxPvIbpPk=;
 b=L6z6NtRikSm2y/rq3+zEU2fzh/elBVFh+oeGbgr0ukkuMwoM8RoV0HIH07vO+XTS80
 ch9jcZW2Tk3NrMsA7L7zaJUr8AAq3DqsBAggehPBzy5rNr7qT2TTyUS9fRr+zzbW1NT5
 e9tFJgsO8z3IAD2vZTAJexeCKt4iWmMFq7ubAoY5xvIEYOZBaZXNyX/q7T7ah+SLpRGk
 HC8LPqbfRA4to9E5CnFc9FzJtiVFL9yasN8XsrgU0so8Nd+0IVvaxokfZ5d0pwWCNQv6
 4YCJxprAJ02qiSpy4fGsa5fIeIawgqZdjCgz+3VoGkdlLCVIElcOvjJCACjOE+LoBkfb
 6IAQ==
X-Gm-Message-State: AOJu0YyHR7TbsQlc9qNLoNfhmiXg4NNW72h7Yt/JFWVric0C+NoN3XD8
 kxGFssMGqZccfYKuCL9Dao3dt/09a92iGedmk6LsdiVRCacG5Ko4hghM+xHPkUAbefCRtmYNk1J
 2wEay/b9EHSkzUA8UW8CjUrXzR01ALDE=
X-Gm-Gg: Acq92OHrwDrk7MC/TUMo71BD6y/omO3SfvcJ61elLZPchejQ4lR6H8U5wM4qK2OPgv8
 WkkBpYhVnwRXIl76wuUH52NWLDJGm0esXpgRVT4KjltSWpwzhMNDR5efT99kiJwNO7vEkMOb+Op
 7S5szEkXSM5U3+UX9ZMT+S52Lgt7KdgVV8S7W+jsK7VrPFfujLBz5NR95egbuhkPR8CV3IgLV9n
 IkLgtqtH1w3OxpuCGpF3YAnWrQaTSahcRr/U8BeQoh0xiaUSBID4Ds+/Ujl17c8aXCn9xBGV57d
 y6WAFASFilCLjDYNX1slf/GSZjOIDxGt+NjvUtYgkxxG3aOqpaBcZp3HGi5xbE1QCS39+xm1ebN
 qddtIfF7w89Vj6O72mWyRZ3cAlBJabPQAzZIySqx7IGbsie9V
X-Received: by 2002:a05:6402:3189:b0:677:1ce0:c08d with SMTP id
 4fb4d7f45d1cf-68256d5ad55mr1768558a12.18.1778690190975; Wed, 13 May 2026
 09:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 13 May 2026 17:36:19 +0100
X-Gm-Features: AVHnY4JRwXZ80d0yR4nvFsZO21eXEaZHD4e5GIyj-I9STRBG0kuhNHn7uMZY0C8
Message-ID: <CALeDE9Ms1dMd2_QJv4g8jWFqtuV=AY-hDPBJ6_eE4S1F5EPJLQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] tpm: Add wolfTPM library support for TPM 2.0
To: Aidan Garske <aidan@wolfssl.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>
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

Hi Aidan,

> This is v4 of the wolfTPM TPM 2.0 stack integration for U-Boot.
>
> What this series does
> ---------------------
>
> wolfTPM (https://github.com/wolfSSL/wolfTPM) is a portable TPM 2.0
> library that provides a full TPM 2.0 command set, an SPI/MMIO HAL,
> and firmware-update support for Infineon SLB9672/SLB9673 hardware.
> This series wires it into U-Boot as an *optional* alternative
> backend behind the existing 'tpm2' command, plus the supporting
> infrastructure to make it run on QEMU+swtpm, sandbox, and real
> Raspberry Pi 4 + Infineon SLB9672 hardware.
>
> Why a second TPM backend
> ------------------------
>
> U-Boot already has a working TPM 2.0 stack and Peter Robinson asked
> in v3 review what value this brings. The honest answer is:
>
>  1. Firmware update support for Infineon SLB9672/SLB9673.  The
>     existing U-Boot TPM 2.0 stack has no firmware-update command;
>     wolfTPM provides the manifest+image flashing flow used by
>     Infineon's recovery / security-patch tooling.  This is the
>     primary "why now" reason for boards shipping Infineon TPM HATs
>     where the field-updatable firmware is part of the supported
>     lifecycle.
>
>  2. Optional native SPI HAL.  The wolfTPM library can talk to a TPM
>     via either (a) U-Boot's existing TPM driver model (the
>     WOLFTPM_LINUX_DEV path; this is what QEMU+swtpm uses in this
>     series) or (b) its own SPI HAL bypassing driver model.  Path (b)
>     is what lets the BCM2835/BCM2711 driver in patch 3 talk straight
>     to the Infineon HAT on a stock Pi 4 without needing the broader
>     TPM uclass machinery.

I don't see what value a HAL provides here, I'm not sure we want to
bypass the driver model. What value does "Not needing the broader
TPM uclass machinery" provide? It's removing one layer, just for the
TPM pieces, and replacing it with another.

It adds a support burden on U-Boot maintainers, potentially having to
debug two different paths when issues are reported as well as the
extra maintenance burden, to achieve basically the same thing. It also
adds a layer of confusion for users.

>  3. Backend selection is a Kconfig switch; CONFIG_TPM_WOLF is
>     default-off and 'tpm2' continues to dispatch to the existing
>     backend unless the user opts in.  No defconfig in tree turns
>     this on today except the new rpi_4_wolftpm one this series adds.

That's not a feature, it's an implementation detail.

> Maintenance
> -----------
>
> wolfTPM is imported as a git subtree under lib/wolftpm (mirroring
> how lib/mbedtls, lib/lwip and dts/upstream are maintained in tree),
> and tools/update-subtree.sh knows about it.  Updates flow through
> the standard `git subtree pull` path, not as separate patches.

That's the technical details, it doesn't describe who takes the added
burden, CVEs, etc

> Note on license: github.com/wolfSSL/wolfTPM currently shows GPL-3.0
> in its repo badge.  wolfSSL is working on a GPLv2-compatible release
> for upstreaming purposes; this series is being sent now to get
> review on the integration shape, with the understanding that the
> license question is being addressed separately by wolfSSL before
> this is appropriate to merge.  I will follow up on the list when
> that's resolved.

From my experience license exceptions, as you mentioned in your
followup email, are a complete pain in the butt, to add to it we're
linking in mbedtls, libdtc, LWIP and there's likely license issues
there too, note I haven't looked, which might be affected because
firmware pieces all link together in a single binary.

> Changes since v3
> ----------------
>
> Addressing review from Peter Robinson on v3:
>
>  - SPI driver copyright attribution fixed to credit the original
>    Linux kernel authors (Chris Boot, Stephen Warren, Martin Sperl)
>    the U-Boot driver is ported from.  The driver is still in this
>    series rather than split off, because nothing else in the tree
>    uses it yet and decoupling it would just create a "blocked on"
>    dependency chain; if reviewers prefer it split, happy to do that
>    in v5.

Please split it out to it's own series, It can be tested with the
standard TPM2 stack using a RPi SLB9672 module. Please see
doc/CONTRIBUTE.rst about patch series for explicit details on this.

>  - rpi_4_defconfig is no longer modified.  v3 added CONFIG_LOG /
>    LOGLEVEL=7 / UNIT_TEST / CONSOLE_RECORD / HEXDUMP to it - that
>    was wrong, it's not what the average RPi user wants.  Instead,
>    v4 adds a *new* rpi_4_wolftpm_defconfig that enables only the
>    bits a wolfTPM user actually needs (SPI + TPM + wolfTPM).  No
>    debug / unit-test pollution.  Users who don't want wolfTPM
>    continue to use rpi_4_defconfig untouched.

It should probably be a rpi_arm64_defconfig derived option, and I am
not enamored, as the Raspberry Pi maintainer, having another option to
maintain and test for regressions. Please at least look at using an
#include at the very least.

>  - The TPM device-tree node for the SLB9670/9672 on RPi 4 has been
>    moved out of bcm2711-rpi-4-b.dts (which is Linux-derived and
>    should match upstream) and into bcm2711-rpi-4-b-u-boot.dtsi
>    (which is the U-Boot convention for U-Boot-only DT additions).
>    This means SystemReady firmware-provided FDTs and the upstream
>    Linux DT are no longer polluted by this series.

That statement is incorrect. The bcm2711-rpi-4-b-u-boot.dtsi additions
still end up in the DT that is provided to the OS via FW DT.

>  - DT changes are now split into three per-device commits (RPi4,
>    QEMU arm64, sandbox) instead of one combined commit.
>  - Commit messages rewritten to explain *why* the change is being
>    made, not just *what* configs are set.

Overall I am quite conflicted on this, I don't see largely what the
value is vs the extra maintenance effort.

I think we might be better off looking at what pieces need to land to
make maintaining this out of tree straight forward and easy for users
that wish to use the alternative option that wolfTPM provides. ATM I
don't know what that would look like, it's just a thought I am
expressing.

Regards,
Peter

> Branch
> ------
>
> Full 16-commit history (including the subtree squash + merge that
> aren't sent to the list because they're too large / are a merge):
>   https://github.com/aidangarske/u-boot wolftpm-v4-patches
>
> Or pull the wolfTPM source straight from
>   https://github.com/wolfssl/wolfTPM @ 664db130d57.
>
> Testing
> -------
>
>  - QEMU arm64 + swtpm Python test framework
>      ./test/py/test.py --bd qemu_arm64 \
>          -k "test_wolftpm and not ut_cmd"
>    matches v3: 19 passed, 2 skipped.  (The 2 skipped are
>    test_wolftpm_change_auth, which requires wolfCrypt, and
>    test_wolftpm_get_capability.)
>  - rpi_4_defconfig (unmodified vanilla path) still builds clean.
>  - rpi_4_wolftpm_defconfig builds clean, TPM node is present in
>    the compiled bcm2711-rpi-4-b.dtb at /soc/spi@7e204000/tpm@1
>    with compatible "infineon,slb9670", "tcg,tpm_tis-spi".
>  - Real Raspberry Pi 4 + Infineon SLB9672 hardware: tpm2 autostart
>    / info / get_capability / pcr_read / pcr_extend / caps / clear
>    all return expected output; firmware-update path verified.
>
> v3 thread:
>   https://lore.kernel.org/u-boot/?q=PATCH+v3+tpm+wolfTPM
>
> Aidan Garske (14):
>   tpm: export tpm_show_device, tpm_set_device, and get_tpm
>   include/hash: add SHA384 hash wrapper declaration for wolfTPM
>   spi: add BCM2835/BCM2711 hardware SPI controller driver
>   arm: dts: bcm2711-rpi-4-b: add Infineon SLB9670/9672 TPM in U-Boot dtsi
>   arm: dts: qemu-arm64: add TPM TIS MMIO node
>   sandbox: dts: add TPM SPI emulator node
>   tpm: add wolfTPM build rules and Kconfig
>   tpm: add wolfTPM headers and SHA384 glue code
>   tpm: add wolfTPM driver helpers and Kconfig options
>   cmd: refactor tpm2 command into frontend/backend architecture
>   tpm: add sandbox TPM SPI emulator
>   test: add wolfTPM C unit tests and Python integration tests
>   doc: add wolfTPM documentation
>   configs: add rpi_4_wolftpm_defconfig
>
> --
> 2.47.3
