Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39589CA0ECC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587F08897C;
	Fri, 30 Aug 2024 03:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NbRh70oQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C818855C; Fri, 30 Aug 2024 03:07:09 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ADFA88D40
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6bf99fee82aso7115656d6.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724980024; x=1725584824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iwbNFtCog/fVnmHq01295K2zj5tPLThPQuub6YO2CGI=;
 b=NbRh70oQTGXpOvmpdNlalP+qz9VbXqdmi1g0UxZwLWp7dU+r+YpwHCtndE0XXFeLeG
 r+aaFoZeUgGKGrxFVsIGtFmmPrmi+YGg6PrS11rc0XJot4fbTrWeKrpgtOIKr5ge0ojP
 TW5rmbSUSV9APrRhXzpNqS2ZZr/jHeKMTmdog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724980024; x=1725584824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iwbNFtCog/fVnmHq01295K2zj5tPLThPQuub6YO2CGI=;
 b=tfcYrRxAT7Khbm4m+vBFGF7TmEyS12GarSj2grGozh2JZaPkBNNGSq2P0UsD8kKRjQ
 BTgE3xdbUWb1zk6Kj8SPHHteLAV2YCLEPg8cQhhkdsl0OBGdKpTvjOvZkVLqAwMFa7tL
 4D9vNvT2Z9LcQLjevfUco4TZDnpPMKHUuRBBixXb6U7PJTv8VPYUldGDkspVj8gurWzY
 n/AtWZFgLURqnmVzFW2LVFIywc3sZREQo6GhQZXShVNo/iACaZB4Bmh44cIkox3QrBWR
 J9R8xtJ9rE4rHNiSokguKJjJ53Qmmjc3+wb+fohN7qZ6+hdWa7OXgH5+4DCQhvFEZTPr
 90FQ==
X-Gm-Message-State: AOJu0Yw5doDhADxdkr3YfQrfQONdyYXpoP7eiDTmgB01Kk8yYkVstnCO
 XuGDId95Z31VQS6psbv0ZU0+H5JeoeJaHoBjD80UrCrRcgEvdzVDwq7R17/ons7LGTPA9X/AskX
 0hMJrHY6gCWVKoIVnd4RxaZ1vGibRIRW/s52s
X-Google-Smtp-Source: AGHT+IGkgknhtUJQCm3SJLgYwGjhCosm3Wbhk80XOBNESQKDIeU62rkWAjHyCfbeapt1XhKSdazcGREYdjYTX8C9ZQ8=
X-Received: by 2002:a0c:e884:0:b0:6c1:6c23:8eaa with SMTP id
 6a1803df08f44-6c33e5dd119mr49680636d6.10.1724980024155; Thu, 29 Aug 2024
 18:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240829192958.GO2479150@bill-the-cat>
In-Reply-To: <20240829192958.GO2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 19:06:53 -0600
Message-ID: <CAFLszTh3hgG3dpYSK_w=DZTJcm59Ct-xQRZPy-00Mh7iGwwaYw@mail.gmail.com>
Subject: Re: My labgrid setup
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Thu, 29 Aug 2024 at 13:30, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> So now that I've posted my u-boot-test-hooks for labgrid:
> https://patchwork.ozlabs.org/project/uboot/patch/20240829185620.3179866-1-trini@konsulko.com/
> the next relevant parts would be how I use that. There's three scripts,
> first of which is "uboot-hw-testcycle.sh" :
> ------------------------ >8 ------------------------
> #!/bin/bash
> set -e
>
> # Save output
> LOG=$HOME/logs/`git describe --abbrev=0`/`date +"%Y-%m-%d-%H%M"`-hw.txt
>
> # Make a base directory
> B=`mktemp -d`
> chmod a+rwX ${B}
>
> cleanup() {
>         # Clean up random outputs
>         [ -d test/py/.pytest_cache ] && find -type d -name __pycache__ | xargs rm -r
>         sudo rm -rf ${B}
>         rm -rf test/py/.pytest_cache
> }
>
> # Cleanups
> trap cleanup INT
> trap cleanup ERR
> trap cleanup EXIT
>
> # Find our arguments
> while test $# -ne 0; do
>         if [ "$1" == "--no-32bit" ]; then
>                 NO32BIT="$1"
>                 shift
>         elif [ "$1" == "--no-64bit" ]; then
>                 NO64BIT="$1"
>                 shift
>         else
>                 echo "Unknown argument $1"
>                 exit 1
>         fi
> done
>
> # Run the build
> if [ -f .gitlab-ci.yml ]; then
>         IMG=`grep ci_runner_image: .azure-pipelines.yml | cut -d ' ' -f 4`
> else
>         IMG=`git grep ci_runner_image: origin/master -- .azure-pipelines.yml | cut -d ' ' -f 4`
> fi
>
> # Build all platforms
> touch $LOG && chmod a+rw $LOG
> sudo docker run  --rm -it --privileged \
>         -v /home/trini/bin:/home/uboot/bin \
>         -v /home/trini/u-boot:/home/uboot/u-boot \
>         -v /home/trini/logs:/home/uboot/logs \
>         -v ${B}:${B} \
>         -w /home/uboot/u-boot/u-boot \
>         -e PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/uboot/u-boot/u-boot-test-hooks/bin \
>         $IMG \
>         /home/uboot/bin/uboot-local-ci-in-docker.sh ${B} $NO32BIT $NO64BIT --log $LOG
>
> # Test all targets
> /home/trini/bin/uboot-local-ci-outside-docker.sh $B $NO32BIT $NO64BIT --log $LOG
>
> less $LOG
> ------------------------ >8 ------------------------
>
> Which is still a little debug-y, but is basically just build everything
> I want in the same container as CI, and then run pytest outside of that
> container. Could I do it inside the container? Maybe. This has grown
> from when I used to build everything on the host and used "flashair" SD
> cards to update my hardware. With labgrid everything might be abstracted
> enough that yes, really, I can stop doing that. I'll likely look in to
> that next just to clean things up more.
>
> Second is "uboot-local-ci-in-docker.sh" as invoked above:
> ------------------------ >8 ------------------------
> #!/bin/bash
> # Build everything we are going to test.
> set -e
>
> # Let git stop being mad about permissions.
> git config --global --add safe.directory /home/uboot/u-boot/u-boot
>
> buildaboard() {
>         # Board is first, all fragments follow.
>         BRD=$1
>         shift 1
>
>         # Second would be to use clang
>         if [ "$1" == "--clang" ]; then
>                 echo "Building $BRD with clang" | tee -a $LOG
>                 OBJ=${B}/${BRD}_clang
>                 export HOSTCC=clang-16
>                 export CC=clang-16
>                 shift 1
>         else
>                 echo "Building $BRD" | tee -a $LOG
>                 OBJ=${B}/${BRD}
>         fi
>         # All that remains are fragments.
>         FRAGS=$@
>
>         make O=${OBJ} ${BRD}_defconfig -s 2>&1 | tee -a $LOG
>         pushd ${OBJ} >/dev/null
>         [ ! -z "${FRAGS}" ] && ${S}/scripts/kconfig/merge_config.sh ${S}/configs/${BRD}_defconfig ${FRAGS} 2>&1 | tee -a $LOG
>         make -sj$(nproc) 2>&1 | tee -a $LOG
>         popd >/dev/null
> }
>
> # Prepare virtualenv
> if [ -f test/py/requirements.txt ]; then
>         virtualenv -p /usr/bin/python3 /tmp/venv
>         . /tmp/venv/bin/activate
>         pip install --quiet -r test/py/requirements.txt
>         pip install --quiet -r doc/sphinx/requirements.txt
>         [ -f tools/buildman/requirements.txt ] && pip install --quiet -r tools/buildman/requirements.txt
> fi
>
> # Find our arguments
> while test $# -ne 0; do
>         if [ "$1" == "--no-32bit" ]; then
>                 NO32BIT="true"
>                 shift
>         elif [ "$1" == "--no-64bit" ]; then
>                 NO64BIT="true"
>                 shift
>         elif [ "$1" == "--log" ]; then
>                 LOG=${2/trini/uboot}
>                 shift 2
>         else
>                 B=$1
>                 shift
>         fi
> done
>
> if [ -z "$LOG" ]; then
>         echo "Must pass --log /path/to/log/file"
>         exit 1
> fi
>
> S=`pwd`
>
> # Common to all newer TI platforms
> export BINMAN_INDIRS=/home/uboot/u-boot/ti-linux-firmware
>
> # Prepare defconfigs with addons
> echo 'CONFIG_UNIT_TEST=y' > ${B}/unittest.config
> echo 'CONFIG_CMD_BOOTMENU=y' > ${B}/general.config
> echo 'CONFIG_CMD_LOG=y' >> ${B}/general.config
> echo '# CONFIG_CMD_BOOTEFI_SELFTEST is not set' > ${B}/noefist.config
> echo 'CONFIG_CMD_BOOTEFI_HELLO=y' > ${B}/bootefi.config
> echo 'CONFIG_CMD_BOOTEFI_SELFTEST=y' >> ${B}/bootefi.config
> echo 'CONFIG_IPV6=y' > ${B}/net.config
> echo 'CONFIG_IPV6_ROUTER_DISCOVERY=y' >> ${B}/net.config
> echo 'CONFIG_CMD_TFTPPUT=y' >> ${B}/net.config
> echo 'CONFIG_FIT=y' >> ${B}/net.config
> echo 'CONFIG_FIT_SIGNATURE=y' >> ${B}/net.config
> echo '# CONFIG_AUTOBOOT_KEYED is not set' > ${B}/noautobootkeyed.config
> echo 'CONFIG_BOOTSTAGE_STASH_ADDR=0x02400000' > ${B}/bootstage-pi.config
> echo 'CONFIG_BOOTSTAGE=y' >> ${B}/bootstage-pi.config
> echo 'CONFIG_BOOTSTAGE_STASH=y' >> ${B}/bootstage-pi.config
> echo 'CONFIG_CMD_BOOTSTAGE=y' >> ${B}/bootstage-pi.config
>
> ## ARM
> if [ -d /opt/gcc-13.2.0-nolibc/arm-linux-gnueabi ]; then
>         export CROSS_COMPILE=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-
> else
>         echo "Toolchain missing for ARM"
>         exit 1
> fi
>
> if [ -z "$NO32BIT" ]; then
>         # Raspberry Pi boards
>         buildaboard rpi_4_32b ${B}/bootefi.config ${B}/net.config ${B}/general.config ${B}/bootstage-pi.config
>         buildaboard rpi_4_32b --clang ${B}/bootefi.config ${B}/net.config ${B}/general.config ${B}/bootstage-pi.config
> fi
>
> if [ -z "$NO64BIT" ]; then
>         ## Build r5 cores for the TI platforms that need both
>         ## Need to backport the kernel fix for cpp with clang and passing the right
>         ## flags.  Then need to figure out pip / venv.
>         buildaboard am64x_evm_r5
>         buildaboard am62x_evm_r5
>         buildaboard am62x_beagleplay_r5
> fi
>
> ## AARCH64
> if [ -d /opt/gcc-13.2.0-nolibc/aarch64-linux ]; then
>         export CROSS_COMPILE=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-
> else
>         echo "Toolchain missing for ARM64"
>         exit 1
> fi
>
> if [ -z "$NO64BIT" ]; then
>         # Raspberry Pi platforms
>         buildaboard rpi_4 ${B}/bootefi.config ${B}/net.config ${B}/general.config ${B}/bootstage-pi.config
>         buildaboard rpi_4 --clang ${B}/bootefi.config ${B}/net.config ${B}/general.config ${B}/bootstage-pi.config
>         buildaboard rpi_arm64 ${B}/bootefi.config ${B}/net.config ${B}/general.config ${B}/bootstage-pi.config
>         buildaboard rpi_arm64 --clang ${B}/bootefi.config ${B}/net.config ${B}/general.config ${B}/bootstage-pi.config
>
>         ## These TI platforms require an R5 core and then Axx core
>         ## Need to backport the kernel fix for cpp with clang and passing the right
>         ## flags.
>         export BL31=/home/uboot/u-boot/external-binaries/am64x-u-boot-binaries/bl31.bin
>         export TEE=/home/uboot/u-boot/external-binaries/am64x-u-boot-binaries/tee-raw.bin
>         buildaboard am64x_evm_a53 ${B}/noefist.config ${B}/net.config ${B}/general.config
>
>         # The AM62x platforms share BL31/TEE.
>         export BL31=/home/uboot/u-boot/external-binaries/am62x-u-boot-binaries/bl31.bin
>         export TEE=/home/uboot/u-boot/external-binaries/am62x-u-boot-binaries/tee-raw.bin
>         buildaboard am62x_evm_a53 ${B}/noefist.config ${B}/net.config ${B}/general.config
>         buildaboard am62x_beagleplay_a53 ${B}/noautobootkeyed.config ${B}/noefist.config ${B}/net.config
> fi
>
> echo "Building complete on `git rev-parse --short HEAD`"
> ------------------------ >8 ------------------------
> Which is a little debug-y but more so comments to self. I setup the
> additional changes to a platform that I want to test with, and then
> build them. For required additional binaries I point them at known good
> copies so I don't have to worry if a failure is because of U-Boot or
> some other project.
>
> Finally we have "uboot-local-ci-outside-docker.sh" which is where pytest
> is actually run.
> ------------------------ >8 ------------------------
> #!/bin/bash
> set -e
>
> # Find our arguments
> while test $# -ne 0; do
>         if [ "$1" == "--no-32bit" ]; then
>                 NO32BIT="true"
>                 shift
>         elif [ "$1" == "--no-64bit" ]; then
>                 NO64BIT="true"
>                 shift
>         elif [ "$1" == "--log" ]; then
>                 LOG=$2
>                 shift 2
>         else
>                 B=$1
>                 shift
>         fi
> done
>
> if [ -z "$LOG" ]; then
>         echo "Must pass --log /path/to/log/file"
>         exit 1
> fi
>
> # Env
> export PATH=${PATH}:/home/trini/u-boot/u-boot-test-hooks/bin:/sbin
> export PYTHONPATH=/home/trini/u-boot/u-boot-test-hooks/py/lootbox:${PYTHONPATH}
>
> # Setup Labgrid variables and use the special virtualenv for now
> export LG_ENV=/home/trini/u-boot/lg_env.yaml
> export LG_CROSSBAR=ws://lootbox.k.g:20408/ws
> export PATH=$PATH:/home/trini/u-boot-test-hooks/bin
> source /home/trini/labgrid-venv/bin/activate
>
> runtestpy() {
>         BT=$1
>         shift 1
>
>         if [ "$1" == "--clang" ]; then
>                 echo "Testing $BT built with clang"
>                 shift 1
>                 BD=${B}/${BT}
>                 RD=${B}/${BT}_clang_results
>                 PD=${B}/${BT}_clang_persistent_data
>         else
>                 echo "Testing $BT"
>                 BD=${B}/${BT}
>                 RD=${B}/${BT}_results
>                 PD=${B}/${BT}_persistent_data
>         fi
>
>         # If we need special pytest arguments do that here.
>         while getopts "sk:" options; do
>                 case $options in
>                         k)
>                                 PA="-k $2"
>                                 shift 2
>                                 ;;
>                 esac
>         done
>
>         labgrid-client -c $LG_ENV -p $LG_PLACE release >/dev/null 2>&1 || true
>         labgrid-client -c $LG_ENV -p $LG_PLACE acquire
>         ./test/py/test.py -ra --bd $BT --build-dir $BD --result-dir $RD \
>                 --persistent-data-dir $PD --exitfirst $PA >> $LOG 2>&1
>         labgrid-client -c $LG_ENV -p $LG_PLACE release
>
> }
>
> if [ -z "$NO64BIT" ]; then
>         export LG_PLACE=rpi4
>         runtestpy rpi_4
>         runtestpy rpi_arm64
>         runtestpy rpi_4 --clang
>         runtestpy rpi_arm64 --clang
>
>         export LG_PLACE=am64-sk
>         runtestpy am64x_evm_a53
>
>         export LG_PLACE=am62-sk
>         runtestpy am62x_evm_a53
>
>         export LG_PLACE=beagleplay
>         runtestpy am62x_beagleplay_a53
>
> fi
>
> if [ -z "$NO32BIT" ]; then
>         export LG_PLACE=rpi4
>         runtestpy rpi_4_32b
>         runtestpy rpi_4_32b --clang
> fi
>
> echo "Tests complete on `git rev-parse --short HEAD`"
> ------------------------ >8 ------------------------
>
> I will say, if there's one thing I don't quite like with how my
> integrations with labgrid work right now it's that acquire/release is
> done the way it is. This is where I think Simon's adding another hook is
> the right direction, if there's not some other hook that can be used and
> I'm just missing.

Thanks for posting this. I know you had described it but this makes a
lot of things clearer.

So basically you have set up builds for the different boards and use
the hook scripts to write them and do the actual power/reset/console
munging.

How do you handle interactive build/run, e.g. to run U-Boot on a
particular board quickly? Also how would gitlab work?

Re acquire/release, I added a -a option to auto-acquire the place and
release it afterwards. But if the console dies then so does Labgrid so
it doesn't release reliably...something to worry about when more
progress is made.

Regards,
Simon
