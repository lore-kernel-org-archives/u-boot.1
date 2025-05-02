Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98215C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 04:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D81868059D;
	Fri,  2 May 2025 06:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JCJNo+4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1921B80F03; Fri,  2 May 2025 06:18:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9281C803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 06:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746159515; x=1746764315; i=xypron.glpk@gmx.de;
 bh=THOnZpDkc8hLd7gxbBT5H/m6SIGmYHkLqiYQez3i0C0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JCJNo+4I/bwWHpWvbaFO9+f5S8l7Wsl68WOl3VFApeCoulEyZCBh1ZrWy8gDPk2A
 PXU8nnRMTI1FpJLPFdpndCKkduWEZtZ947OpcfCgAwZSlfobNJpwD/PF9KOtuBdBy
 VCJTT6gpi08G7k1yCZqRC3fifJjQnAem3bULjaf4HtEsbRC1IK2Pm8bhmUrpRtlGV
 Jy7dSitHAaG8ZsMvlNwxBtBwpldFzvzVCi8bBR2s2qVGSzhWgkoT3IzF6pEKGL/+W
 pMSgYMve8UMa941hvN2yhLCXgMToye28fdO2QK7K3dkWeE14qKT8c+iMH49f00I+d
 Zx6/QFSP5N5zdeJKkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.105.83]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1uHuj23DPG-00Dg1z; Fri, 02
 May 2025 06:18:35 +0200
Date: Fri, 02 May 2025 06:18:33 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/3] CI: Update to use the hooks in the U-Boot repo
User-Agent: Thunderbird for Android
In-Reply-To: <20250502025026.4140184-4-sjg@chromium.org>
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502025026.4140184-4-sjg@chromium.org>
Message-ID: <B46E93DD-0DAE-4296-B28C-4AB518778DA0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:70G3hp2HEH3Vo+P9I0sWD3iWZvzu0EOTfDCGadBwcT/olTz88wM
 UpoQdv4TjUIgflUbzu9+ClrnaAnphVKPM8QjSfuhB5BxCB/EjPhaGjW8VyoSZKNVuWHKWa+
 1wrrPLeBxQuO2kq6mCfgaNGgwUN0HsnYiRntx3LqFPi7hX2gRQQ8ytRMYTjmEv+e5PD/49W
 9c4HbRmpoZDSupfukG47Q==
UI-OutboundReport: notjunk:1;M01:P0:Idu/AIbESag=;rQIrM5UM5hVOyWK5YHosGqgHT48
 Ek8xMqxcg2hJ33OZf+6i/AsBswr00ZTTcGIq9IjXQBb8oRbUBxnQLVPvrSN+2DNAVYlqhFfV/
 Vg+4rXyJoBilTMel7/SajAKL02UkKDe/GkUIJCMhmpz/QtDIElfwzBnQ0JosWPficBbqyKXaS
 iVfEi+aGPHuHlYUIwkf1pBxIM671SWuDl87ygQw5RISA3SJVLTdRDpF1rSJTQ0XWgjCbQoecR
 MFmYl9nFcFFDuLh3mv7OO+0VibNzw5nwhfoqAVbdi8WZbpSLBAkKm8dbuT0F3WQlEwvTQQFNE
 Wc0BWJGZPCHG1c6z8yhZHsQtJeSXV+pVVYyiMrs/G1dMBlZ3r6MxRtZuL0fxRcvD1PQEA14MK
 69Zh0GlNtluMDEJNyuZWPm5A2fiDdBfK1Dr63ZGRneN6k2NKOhAJeI9DfBVbCvGXrFQ0D772a
 cWyb6a3J/FjsZS+capcNMbNGpC5dHFZOU64CJPe3/evFEwSDCtM5Af+qYtuXfPqZFicR7U3Dg
 J5jF1LyYikI7HD1g3HqE6qo0kYZAFKPyl/pSMfj0wcfvU+2bm6F3wR1S6o6iU/4+wRKOx9Mzv
 CB2YaTyoVMSW4zVyY8ZL6kW0vtWlTJ29crEK+nseOi32pToiv9+nOFW/JdV3ZAsS8HgX2lRrg
 fc/QYQT0RMSKlCeNbvc9ENBlRX8KOy90FQZVIAchBLlMhWFwsG+2k12GTFs96sD7k33iJo6BD
 NNwG5nQkU39KGxlLPdkVfqJexLwSF4ksnrLykpiURCV0wwcXOpELhBtUqAVPSKe8kchuBS76m
 HHIssOqWSOBPncJ/nCUsgAyWCsFpvz25MnfADpBkYD8sC7d9kunU9Lq2oyVNfc/9wArd3IhT+
 WCP8LfJ7kCPbRXykSDrjE0wq3e50wayJlC2gHKJqgEYkyKvY6qKPh5gm4hwNpT2kfS7K8aLtB
 SQttuXNxGZRK1XZgFJMUMtmoqDl3O7v3KJoyG/iBWlhfhHEqPfh4ZZlZpw2V5DV4xw3xMMZL5
 Lp75CCPKpITlCNCCrQZicVOdifhKatZ7HQh+ykMK8kcz1YzT6VTJTQnlZDckSmP1j68oHa4xh
 D49RSaqKIs/Y4Pw3GSeXjJx4LLYnA7mtiW5WMICgI9QKkwWGbMO6kEkhJNqvQ86Eyp0MZ0k00
 qxFJCPYfObmwG9cuQpx5P8l1Sfhl+IkiCs7WoUj9LmvXQ49p5lSnv2de/Mxbe5JhJw4x9pZpn
 ZMRVsdEO7AHckjLCYlutOt4g5UZdi7XKlI7RqTZUWHLZLIFN4m5YvUoueWsSR7EZ0/R9y/+RV
 Waf7qf1P0OX3/HJyrMclAsImydjSfL6w7xor0daKskoriqiANabwnYYHzpBHMeBR6uH7iE/iL
 PFGTMmXWYjMGNOU0gfU+FIiOZCKp4PFGtFpI04wqlXhUFgZSoz8c9pLeg3j2IrLSgScKQJUkV
 ge29olLucj8SHsMLLTfwOB6Jbbt/1z/SsXPxrliSM4sdeQ+g2O7jxgPYzHmVHR2mVSoPfc9Ss
 P9nFBx+W8jneYum78PWnu9XwX19QTsi75IQh0OOEBcFczlRgFiE4G4pEk1K8DfELCWl3cxd8U
 UICZhZ1YHeRWw5AyvSSbjZ/lEmqjoyk8D6S38FQ8EhsQBxPTwMT60Rt3ctWR/bskQ/2U7HwK8
 4pJZ5sEPlFzLB29uNLuJCzc5Rcw0yBbKpAdj6KnOrJRpFRaouhdLxqovSTuh2IWg2x2O0iuKk
 61Uj2LJylqd0CswYv+gbIXdmJ8gM72d/Okxbtt94M4Hbt0nPFBlbf6/nbZg5W6eC1dnmrvklT
 pfuozao+ERbZL3kJo6BBfsym1/TNut31t1IE6CGvntG6gO8jOj89iUqu4J4Y3fzBEuyQkDfD7
 vtlDP8o8Rsmc71h+UaPVMX45bAAffSB/lH8Cri1MuyH0F5UEzAjRKE8SWrWdLNYKrL+o181uo
 1tC89AMFwG2amyYgpMynekd5TBrxOdfRRvlyNB6enjX3OAwy5w36x2LxCzQF6pa5jpHQmMycb
 eVUQRXVhBc1M7AFrycvJh6T8zyFhgIeZ9qno7LTF5sKNqSEoloxi/zI2rgyZKwBOnXNIjtuvN
 s9wDrQuA8BZZuKB0Kqt87JGoiXZHjJXDKb1QAOO7obJPCPeCLllRuMkhGsaQnNFqVXqAh0qYG
 kDQaJmgoOSz1tEbe9W1wqFCr9xePju0kFqWLDJGc2WFfk1jxKTxkLuOiP88AcgT1VZ6amzye0
 gupy+n7WMrxOni/OUyQg1XeInO/6nLZgicwQU9wC7r0HaVuc5+C5eHRw/nRQ1QHqcrBYsAnj6
 lmzPOsTZJf8UFfSlxrBonvt1BUlxN667UaIQEjSI9MreHmvRBAyKT24mTueuQlc/ifsEsaAZJ
 SNUbn/amFO9SZNsMDYRw+M9g8gaRwt59L9WNaWoXXLEBXgaAwr0v0LCUv0LclEkm28w64T35C
 LcB5UK8esQs5CgGJthcA3AtjkiWFoghiJWSaO2p/4hRCWQE+xpuoPOm7eKLoljmK8C4LOhbB2
 sMF6l3QJpPSAEL/1eXj9f+SQtmGfYGNPi03+4gpvqTyfEyR3+1bTH3jvs1MJbVO3wdo0uhLbb
 uVN6kd504plPdlnv8SwNxqVgabjufaScxbZHB51mxIQVJugiw/LR52ozaKMikN/Ni7/QxLgoS
 pTfE0wK4nbjJZMJHj/G/ql+RjNhLOBIgQkdDzK22ciH2Na0BuvTid/unYcCLPGXoEiIqmtstC
 bCbyKuYJI03NcLlSGIMavKiOegT7es2zhLx741ngJ6vGRNGr92bjM3mW59Bm+LWNC4gMyAlaj
 mHyNgPhjO2ahd7lhwtxFva4703sFSXzpTCz55PhIi6Rzhv2KxIdBUxFjlzmY2pG325WtLiAxA
 TDEn66v0b8ZGcgS+zYZ7sgBn2KRuHTQs84kxF/uRux/PFZvz9dXW2hzazpr8b0qHeE2I4XVNz
 S6zz2s5PAzqhNtoKmzjTWch2CcijqQSoU5nmwgPxtNrEDq1ZV5EFBHIXKdEI6qe0lp6DqDtou
 Gc9p+hY0wxaoIpK1Px2hyyxmnjdJQ2Du9qV31zme1AR5sNOtNLYKjJPIrwpNlfvxV0Ag4Vyhm
 Fk6Dvff2E1HPzf4+KwnAincEtYXEEKM9e8q19NAWbP7nf3wCIb0Vrgq1SRUvL3U4FnB+HaqzU
 TAac=
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

Am 2=2E Mai 2025 04:50:19 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Now that the hooks are present, make use of them directly rather than
>cloning the separate repo=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>

Using the same git repo makes testing changes in the test hooks much easie=
r=2E

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
>
> =2Eazure-pipelines=2Eyml | 15 +++++++--------
> =2Egitlab-ci=2Eyml       | 16 +++++++---------
> 2 files changed, 14 insertions(+), 17 deletions(-)
>
>diff --git a/=2Eazure-pipelines=2Eyml b/=2Eazure-pipelines=2Eyml
>index a00ee67f297=2E=2Ebf50727ea55 100644
>--- a/=2Eazure-pipelines=2Eyml
>+++ b/=2Eazure-pipelines=2Eyml
>@@ -251,13 +251,12 @@ stages:
>           # the below corresponds to =2Egitlab-ci=2Eyml "before_script"
>           cd \${WORK_DIR}
>           git config --global --add safe=2Edirectory \${WORK_DIR}
>-          git clone --depth=3D1 https://source=2Edenx=2Ede/u-boot/u-boot=
-test-hooks /tmp/uboot-test-hooks
>           # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with=
 NET_LWIP enabled=2E
>           # The test config and the boardenv file from qemu_arm64 can be=
 re-used so create symlinks
>-          ln -s conf=2Eqemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci=
/conf=2Eqemu_arm64_lwip_na
>-          ln -s u_boot_boardenv_qemu_arm64_na=2Epy /tmp/uboot-test-hooks=
/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na=2Epy
>-          ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
>-          ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
>+          ln -s conf=2Eqemu_arm64_na test/hooks/bin/travis-ci/conf=2Eqem=
u_arm64_lwip_na
>+          ln -s u_boot_boardenv_qemu_arm64_na=2Epy test/hooks/py/travis-=
ci/u_boot_boardenv_qemu_arm64_lwip_na=2Epy
>+          ln -s travis-ci test/hooks/bin/\`hostname\`
>+          ln -s travis-ci test/hooks/py/\`hostname\`
>           if [[ "\${TEST_PY_BD}" =3D=3D "qemu-riscv32_spl" ]]; then
>               wget -O - https://github=2Ecom/riscv-software-src/opensbi/=
releases/download/v1=2E3=2E1/opensbi-1=2E3=2E1-rv-bin=2Etar=2Exz | tar -C /=
tmp -xJ;
>               export OPENSBI=3D/tmp/opensbi-1=2E3=2E1-rv-bin/share/opens=
bi/ilp32/generic/firmware/fw_dynamic=2Ebin;
>@@ -307,12 +306,12 @@ stages:
>               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot=
=2Erom remove -n fallback/payload;
>               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot=
=2Erom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot=2Ebin -n fallba=
ck/payload -c LZMA -l 0x1110000 -e 0x1110000;
>           fi
>-          export PATH=3D/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
>-          export PYTHONPATH=3D/tmp/uboot-test-hooks/py/travis-ci
>+          export PATH=3D/opt/qemu/bin:test/hooks/bin:\${PATH}
>+          export PYTHONPATH=3Dtest/hooks/py/travis-ci
>           # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \=
$var" if not
>           =2E/test/py/test=2Epy -ra -o cache_dir=3D"\$UBOOT_TRAVIS_BUILD=
_DIR"/=2Epytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_EXTRA} =
\${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAV=
IS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=3D\$(Syste=
m=2EDefaultWorkingDirectory)/results=2Exml
>           # the below corresponds to =2Egitlab-ci=2Eyml "after_script"
>-          rm -rf /tmp/uboot-test-hooks /tmp/venv
>+          rm -rf /tmp/venv
>           EOF
>       - task: CopyFiles@2
>         displayName: 'Copy test=2Esh for later usage'
>diff --git a/=2Egitlab-ci=2Eyml b/=2Egitlab-ci=2Eyml
>index 9f69895efd8=2E=2Eba9ca5fb9e0 100644
>--- a/=2Egitlab-ci=2Eyml
>+++ b/=2Egitlab-ci=2Eyml
>@@ -30,15 +30,13 @@ stages:
>   rules:
>     - when: always
>   before_script:
>-    # Clone uboot-test-hooks
>     - git config --global --add safe=2Edirectory "${CI_PROJECT_DIR}"
>-    - git clone --depth=3D1 https://source=2Edenx=2Ede/u-boot/u-boot-tes=
t-hooks /tmp/uboot-test-hooks
>     # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_L=
WIP enabled=2E
>     # The test config and the boardenv file from qemu_arm64 can be re-us=
ed so create symlinks
>-    - ln -s conf=2Eqemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/con=
f=2Eqemu_arm64_lwip_na
>-    - ln -s u_boot_boardenv_qemu_arm64_na=2Epy /tmp/uboot-test-hooks/py/=
travis-ci/u_boot_boardenv_qemu_arm64_lwip_na=2Epy
>-    - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
>-    - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
>+    - ln -s conf=2Eqemu_arm64_na test/hooks/bin/travis-ci/conf=2Eqemu_ar=
m64_lwip_na
>+    - ln -s u_boot_boardenv_qemu_arm64_na=2Epy test/hooks/py/travis-ci/u=
_boot_boardenv_qemu_arm64_lwip_na=2Epy
>+    - ln -s travis-ci test/hooks/bin/`hostname`
>+    - ln -s travis-ci test/hooks/py/`hostname`
>     - if [[ "${TEST_PY_BD}" =3D=3D "qemu-riscv32_spl" ]]; then
>         wget -O - https://github=2Ecom/riscv-software-src/opensbi/releas=
es/download/v1=2E3=2E1/opensbi-1=2E3=2E1-rv-bin=2Etar=2Exz | tar -C /tmp -x=
J;
>         export OPENSBI=3D/tmp/opensbi-1=2E3=2E1-rv-bin/share/opensbi/ilp=
32/generic/firmware/fw_dynamic=2Ebin;
>@@ -60,7 +58,7 @@ stages:
>=20
>   after_script:
>     - cp -v /tmp/${TEST_PY_BD}/*=2E{html,css,xml} =2E
>-    - rm -rf /tmp/uboot-test-hooks /tmp/venv
>+    - rm -rf /tmp/venv
>   script:
>     # If we've been asked to use clang only do one configuration=2E
>     - export UBOOT_TRAVIS_BUILD_DIR=3D/tmp/${TEST_PY_BD}
>@@ -93,8 +91,8 @@ stages:
>         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot=2Erom =
add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot=2Ebin -n fallback/paylo=
ad -c LZMA -l 0x1110000 -e 0x1110000;
>       fi
>     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if n=
ot
>-    - export PATH=3D/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
>-      export PYTHONPATH=3D/tmp/uboot-test-hooks/py/travis-ci;
>+    - export PATH=3D/opt/qemu/bin:test/hooks/bin:${PATH};
>+      export PYTHONPATH=3Dtest/hooks/py/travis-ci;
>       =2E/test/py/test=2Epy -ra --bd ${TEST_PY_BD} ${TEST_PY_ID} ${TEST_=
PY_EXTRA}
>         ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
>         --build-dir "$UBOOT_TRAVIS_BUILD_DIR"

