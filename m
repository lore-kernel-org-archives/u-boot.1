Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD0606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rdkPuU8Z;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zAU1PkrP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9EA460A60;
	Wed, 18 Nov 2026 12:27:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IzjLLWkKiXRp; Wed, 18 Nov 2026 12:27:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF7DD60A51
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795004873;
	b=C0ewoEU2xJMcs0KKqnUxqyzDBIlWois3mUcbatG/0lNVZxirlFEvnW8w2TwZXqGp9UCB
	 t1erntETVb5P5uew2tlZMOcTcrdUH8vfQSoZh5FOSfokmSJHCm4pqsqfHAFggSBYHwJCc
	 wZD3UwORaEVtw2XeEfg+Kf8DPqVD8J9/gIHAQvLol9YLBBdWx6PyOPQIawms+mnJv0p4T
	 vveg/DGwZA2WUY4uoEsiDpv+CjtnMuJawLA0ERcNsfcUX8u0CwJsrK+GA4EXwUOgoJpBZ
	 ZoqLFs9ZSJXrLyjapV/M0Xf4iT6pPrpscatj3Ssru2+4/WOvvnh22ZNwatTJ164exTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795004873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rfdto9m2afjUAkMZqJSCuurx74XGhGmL22ZqFkI8eyc=;
	b=dSm6UE9SLhXC0XWYrcxgJzuyvANcGLAbK3TH7PpeydGq4xmILduCyD8W9Zyo8aRMhINe
	 +eF9nvs908L9TLEA7K9Ijng1jlkocWpjHyApY+ZruNJaKIBlkh8wsjj3SDm943Jg3ij4M
	 yTuG0xSLco5rdBMn+8AIcRyoVYsknJMyl1YEy3iDxduYq4/ozgx7uDESgG/Y0MPWezvtf
	 6Vyx5II1bVqn3V0BCLo1ORki1zoDqiuNLrDJsGXbin7VyHycphNTQWTrw8Td8zVMM09GW
	 on7Ymxic+vWBOkdMO1SOeUWLB9E8pDlKwEIPSK4hGSY3SwxpGqUBAi/pJGhGeBAbD7Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795004873;
	bh=rfdto9m2afjUAkMZqJSCuurx74XGhGmL22ZqFkI8eyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rdkPuU8ZyJN5SZ7wXjmisPdscNMSGwg+o0JWOLYv4vYjgoRAA2PRxI5AU6TDzETKF
	 3x4z/Jf6WwdFl4nRhAwd1/hAO6Rny0iHMKRJJmXvd5JJpNYywPJbQFF+02LGLVIHdD
	 6+DSF1AGi4KrOdOEnWVwWDVPoxrpuQD8rRFAGoXCPloPup0QRUYndNBiGAIvH4gEvO
	 08by5kgSHJ6KSXoHQV0pjZs8VSgmRDO1OeQMrhUHIqddffdSpnJwu2Jj9ljPZc0nRn
	 I+UBlnmTl8KYDmAjRUF/5TAi32dnBdrMdaop2jj0fDbBS/sGEFauS+1lpIUXCthcHH
	 0t2UY9A0+LXEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF7DD60A51;
	Wed, 18 Nov 2026 12:27:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 404CD70B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F3D1409DE
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6P2OEU7DWjl for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 12:27:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1162C409D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1132"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zAU1PkrP
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1162C409D9
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:27:51 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b4d07494b0so24417857b3.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795004870; x=1795609670;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rfdto9m2afjUAkMZqJSCuurx74XGhGmL22ZqFkI8eyc=;
 b=zAU1PkrPRED8amZ/sWykwDxxPVZvkPEWFxq5HJR4XYFPzbR+ymvi7Z6iWqOYK8pwib
 7S/DvuYeO7y11nZPN5Sny+tLxNgQ7ddbsJslDLrmSSheIh5oQYUK0VCYPhO1vL7qTcph
 Jmo2p/bTMVJdWiXf0qf+Sf3/t0ldSKKqpuzHiwpMPZ2lUeCWWBan+soWphzVS7VQY3Ul
 kL4PeGrqwIRuq14f9QM4+hUx8v/J/RjWmDXo1jet+lw8nHwSDro/ixxhluvQFZpaKCcr
 VlZ49oCzt3Qs9V4VBJ2o8dRXt9Wko+5Oqu4zGN4Y+n+Oq4l1LhKjjo7TrM19AZL4gucB
 adgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795004870; x=1795609670;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rfdto9m2afjUAkMZqJSCuurx74XGhGmL22ZqFkI8eyc=;
 b=dfG06qhiShPKG56E2MQP/tjd/ZgLApM7rm5j8WxQPAGvFxYeGtLI6LrgNW8KTybLUu
 yJ7ZIh0F6Lr9CaUx6imm31RLTzuS0591s9ahM28lW4RGdB7/Jq5NSgjqhEPeKj2ip0vw
 PMnXfrjV+/6JWCwlHaMDDaTFN8vVrMTiV8XCguO+PxNDY/6uFrg3Jb6GhEsIYh8jnLln
 mPMvNy4bWcQafQSYLCn20HBoiwHfhNsQukJ9hVJXFFoVErK021nv47WdHgQfOmIglBQa
 yi1jgjQYy8Ve7yeTj64grwITvDdxw+3CiEMgEet681ygtxwdY7ZFaQuusGu15dGmumfd
 FTxg==
X-Gm-Message-State: APuU4Z+eVLyA56KgRL2IddK5m5jut5nO5KL9EloLz3aYd9u4yZLHCI3O
 0d5BOcq9aMK3L1g7xYEmJsXr998/gDQM3+kaP5cl1NfaXntVMkHau10YQsoilmDCJAuJ51j51rL
 apNqDfZDq3Ixrskl9vXykssOrWl6CF/UQoWitIteybg==
X-Gm-Gg: AZFdTZd61rC6TFJhmGGwIEJea0tjmMVoxwr6dr8YeEOMw/cZBqOsIlpNJKVy/9LmzcJ
 jAjgIBWy4wPAfxCVvYnr0z7qEuydASrfe0oQ5ye7b+MegggZGWOJauX2ZhdT5RB7zAaXRq1hiVK
 khdDlC9lWR8i+n5vGrVESgu9YblcyNS5KyMOh/LLFt7KCNgboU863Hb6nkcsuiX8jFEXUNdB7Aq
 /eW4uILqfj/6grSgUaduy8pAkSimqVQ5qJc6JNExQ2sKvDf7vT8Ebw9PsAg5ck4L8H1zTdwOIvb
 hIbbXgp5qTo9hfmsSo5IG25/iMeLcn7KxqH/9Yyov/pRPB2zK4pqGtR9Smch84awHiGh/mqzlaE
 qdHqQJ1meblELwNL99p4ofY4eMNDzso+wbwwqkbowweQBW2yIL2rctopa77f6Q644ZWDQ40SCcz
 gmrj3BGbfPj3UR98FnUCbnNGW+NCetY7yqGUtp5O5jYvJRLmpyarMj74nuAFqqL4FMIOLbmTeJA
 +dI6M3BmkO59lVSpyFmbz8sUE+uDPofgPS+Ouzx9uHZgeqKs4xc6hxJv3+fODtPvSHkpa5YvfFF
 Wy9QYCLOlve7D8VdK2Vy5TFmR3ihzPvCFBiQ38JEXgOy31J9AcW9nGfj/KPWpP+IG5aDiurhP1n
 pKQasGleLQ4BcmD9gZ2eO+5by4LKfzWq98gvi0/nG+pjOhW9MvxIpYFSVyaLRvBf/XselLQUVxR
 FoVMVnqMjPF7ustUvCI3Yq3Ad2CzXK0dazIt40ZjZkYJL6kGOFTugzlvhs2BA71F1G1ooUP97yu
 3Q6LcKau4tMo/vEWNIC
X-Received: by 2002:a53:ac94:0:b0:67b:ea3a:1543 with SMTP id
 956f58d0204a3-67dc7869e6dmr2850251d50.14.1795004870163; Wed, 18 Nov 2026
 04:27:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
 <e26b56f1-6766-4b7a-80f5-811f6d14e35c@gmail.com>
In-Reply-To: <e26b56f1-6766-4b7a-80f5-811f6d14e35c@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Nov 2026 14:27:13 +0200
X-Gm-Features: AclHuK_8frAYl45gkAvC2oHC3lCewyMij-E45EgSbbrAxbDnX1SoLgEExT_Z3lI
Message-ID: <CAC_iWjL1RMGssGUP08ow75FMdQiF9-L4C47QUZrtw7DWaYMWcw@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] test: py: test invalid certificate lengths in
 signed images
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 23:57, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> Add a Secure Boot test with two signed images whose first certificate has
> an invalid length: zero, which made efi_image_authenticate() loop
> forever, and one larger than the certificate table. Both images must be
> rejected.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  test/py/tests/test_efi_secboot/conftest.py    | 31 ++++++++++++++++
>  test/py/tests/test_efi_secboot/test_signed.py | 36 +++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
> index 0755497d46d..9858dd36f17 100644
> --- a/test/py/tests/test_efi_secboot/conftest.py
> +++ b/test/py/tests/test_efi_secboot/conftest.py
> @@ -4,11 +4,36 @@
>
>  """Fixture for UEFI secure boot test."""
>
> +import struct
>  from subprocess import call, check_call, CalledProcessError
>  from tests import fs_helper
>  import pytest
>  from defs import *
>
> +
> +def set_cert_length(src, dst, length):
> +    """Copy a signed image, setting the length of its first certificate.
> +
> +    Args:
> +        src: Path of the signed image.
> +        dst: Path of the image to write.
> +        length: dwLength to set, or None for one past the certificate table.
> +    """
> +    with open(src, 'rb') as inf:
> +        data = bytearray(inf.read())
> +    pe_off = struct.unpack_from('<I', data, 0x3c)[0]
> +    opt_off = pe_off + 24
> +    magic = struct.unpack_from('<H', data, opt_off)[0]
> +    # The data directories follow the PE32+ or the PE32 optional header
> +    dirs_off = opt_off + (112 if magic == 0x20b else 96)
> +    # The certificate table is data directory 4
> +    cert_off, cert_size = struct.unpack_from('<II', data, dirs_off + 4 * 8)
> +    if length is None:
> +        length = cert_size + 8
> +    struct.pack_into('<I', data, cert_off, length)
> +    with open(dst, 'wb') as outf:
> +        outf.write(data)
> +
>  @pytest.fixture(scope='function')
>  def efi_boot_env(request, ubman):
>      """Set up a file system to be used in UEFI secure boot test.
> @@ -118,6 +143,12 @@ def efi_boot_env(request, ubman):
>          # Create a corrupted signed image
>          check_call('cd %s; sh %s/test/py/tests/test_efi_secboot/forge_image.sh helloworld.efi.signed helloworld_forged.efi.signed'
>                     % (mnt_point, ubman.config.source_dir), shell=True)
> +        # Create signed images with an invalid certificate length
> +        set_cert_length('%s/helloworld.efi.signed' % mnt_point,
> +                        '%s/helloworld_certlen0.efi.signed' % mnt_point, 0)
> +        set_cert_length('%s/helloworld.efi.signed' % mnt_point,
> +                        '%s/helloworld_certlen_long.efi.signed' % mnt_point,
> +                        None)
>          # Digest image
>          check_call('cd %s; %shash-to-efi-sig-list helloworld.efi db_hello.hash; %ssign-efi-sig-list -t "2020-04-07" -c KEK.crt -k KEK.key db db_hello.hash db_hello.auth'
>                     % (mnt_point, EFITOOLS_PATH, EFITOOLS_PATH),
> diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tests/test_efi_secboot/test_signed.py
> index 9e6d3fdf8d8..d14f9b795d5 100644
> --- a/test/py/tests/test_efi_secboot/test_signed.py
> +++ b/test/py/tests/test_efi_secboot/test_signed.py
> @@ -378,3 +378,39 @@ class TestEfiSignedImage(object):
>                  'printenv -e -n PK'])
>              assert 'Failed to set EFI variable' not in ''.join(output)
>              assert '\"PK\" not defined' in ''.join(output)
> +
> +    def test_efi_signed_image_auth9(self, ubman, efi_boot_env):
> +        """
> +        Test Case 9 - Secure boot is in force,
> +                      the length of the certificate in the signed image
> +                      is invalid.
> +                      Must be rejected.
> +        """
> +        ubman.restart_uboot()
> +        disk_img = efi_boot_env
> +        with ubman.log.section('Test Case 9a'):
> +            # Test Case 9a, certificate length of zero
> +            output = ubman.run_command_list([
> +                'host bind 0 %s' % disk_img,
> +                'fatload host 0:1 4000000 db.auth',
> +                'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
> +                'fatload host 0:1 4000000 KEK.auth',
> +                'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
> +                'fatload host 0:1 4000000 PK.auth',
> +                'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
> +            assert 'Failed to set EFI variable' not in ''.join(output)
> +            output = ubman.run_command_list([
> +                'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld_certlen0.efi.signed -s ""',
> +                'efidebug boot order 1',
> +                'efidebug test bootmgr'])
> +            assert '\'HELLO1\' failed' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
> +
> +        with ubman.log.section('Test Case 9b'):
> +            # Test Case 9b, certificate longer than the certificate table
> +            output = ubman.run_command_list([
> +                'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld_certlen_long.efi.signed -s ""',
> +                'efidebug boot order 2',
> +                'efidebug test bootmgr'])
> +            assert '\'HELLO2\' failed' in ''.join(output)
> +            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
