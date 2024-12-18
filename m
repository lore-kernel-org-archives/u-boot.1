Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C441BE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 275288021A;
	Wed, 18 Dec 2024 13:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sPAqZjO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 673FB8021D; Wed, 18 Dec 2024 13:09:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41EA980214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734523751; x=1735128551; i=xypron.glpk@gmx.de;
 bh=9zHgst54C4Czy3YJIeXtHgcpbPJFlFOREAuukXl10s4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sPAqZjO4RJEu0DWZ5MRYXYEKKLjMeYnbi0grhQEHjaFo5nqgnmTGD7WrBpck/Tgl
 YmrtGqhXSoDIrS2mjKkMax6xBTk7CDZSVBe6vLGUl88yRz8KJ9vsqYczNpf1tN5Bo
 Q6TlrWOnlDkH8VlZZ5WsiVlHKnIDgU8ueJY7jcNWx0DYJXO/hlWPXX7pxiGwxq2Pf
 Wckk6Jo1hrXFBwD3mLUoeD+0egcYzGOtR2pZxtRAB7W6rl2YJLwBwOBdMPMcRvm/v
 xfCzvQaFmcQoLA79IO7q7YwNrp/MwPBYHUcGLjDcBFaoIZwdELvnDqkFIv2cQwRje
 03SDKjK5cZn5uWH+rQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.110.29]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXuB-1t4v4C0eFz-00XcQR; Wed, 18
 Dec 2024 13:09:11 +0100
Message-ID: <0a1b7c12-a8d7-46c2-9c00-4914d3286bc4@gmx.de>
Date: Wed, 18 Dec 2024 13:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: efi: Attempt to support automatically running SCT
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241211004640.3778457-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241211004640.3778457-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:66LQlkwEelToMeBImhhMbVhoIUGt3Xy1tWwSjLz+UrUDQO03iun
 cv9RqH91GY6vZUOxcW3WJiFnmsOLMKKBqDjBRr5s8xpzuGQNbKx1bKl7qPgc5WZDlXtbcq+
 euoJJ9R3DfoVEGr+ZkyVeeVU8g/fLlhxjVBRgAzW8HFdLqJAvBb9WZlKrusdB7O+50WMa5b
 HliYw/7pxQRoeJmujA7tg==
UI-OutboundReport: notjunk:1;M01:P0:a6hYW0iRWWk=;J3RdMHcTnl1bUQQqEiZDBOGlZ3i
 YdqXvpiAoQGCScPvMfWL6Eu5qS/aSx3LEaQW0PD0WkiKKWNavQoGnv7KHN4MvcxXkL1VnB+hZ
 VhKmTwT7qoNSldk85+DbxV5hGEYHAYUL7JwyruPlarvzNuTpRYSEddlnRrpFKIBHiIGCF0OWY
 LLVcs3ZEqP0Rdss5LpnlurPT2ftniWJfI8EeD6HOL3z4jSeNDIww2pIn+wOPVoc0UPMJUjEb3
 f3jRK40A9WxYZSGP+p7JLx3yZvDtuqXVRW0MvGal2fkQ+p37ijp5XjVKkMw7U2PSfcK6dkVVQ
 EJW2sYe1KGjcimU8Vk5BcQQAGSeHG5RZUtEWNXVWekEszCbZtJs43FO7ps03dbjXSUKArh18D
 fAjGMeimepYcISbKn9D37TGib7P7jL7gykt4+RbQ9X9jdw/E1e4X8Cigz2rgc9h1OLJZE9rsY
 KC2ozka//5BNFUCPUvcQQz7UEsxsIxsUvWOsgwJozqasbCo6xziVsOB/dBjsDMpDQhLiBMcX/
 5BbAlDKrfvPqGEgZB393zWxmNz7YYQrO/YlvMRlTCVNXEy7vDtvdt8wyUG1wMyx2NJy3aAJnX
 huPtlihDPAtUseKXi3Q7JdFXr5Gh4ZPXQE9IoW9LFHtbf0bO0/twCyqM1yu762zrsby6YUsx/
 zish6Its7GVhlzc4yWkONe5rU6qwNJ5QBrexl+kHb8hUnYWBQjEGQqrbfM7DCeoBY0h19CIqY
 GPcmJvJdS5J/6F80tGqQaheDzPKr1ljl+pTJN44RO347ZgIYvcVlE315AZFZLCiJEiIn8SOn6
 OvUvlaA2cdlbtLk3ZA0hSHGJ0cwwWV93g9mSOT/aOov79kwgnZmJJWDkpBVDGRMh1UdDlrYqP
 fNkVQ5sWtqP0eW5eONJEUyX//dV1WYnpYapZzdxJT0Vb9f2lu9z0CeokHqxmBlkR5ssyRC8ei
 gzvUh3+QL2ub7HL5iWZjL2zMQQtaO0GMqYZIMjiO0o2mAIuNXI35UqoDyZvr4X3R7vQHNsCWK
 +KYkxHq860c7XRup249dqTUqgVvWkAjSXLvNi7hsResExiE2tcgJjvJrePqfV+nVC+S5ylDiw
 9xDwZCn9jKTZYxQRDyWAvW4f2ZNDbt
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

On 11.12.24 01:46, Simon Glass wrote:
> This is a feeble attempt to update the qemu script to run a selection of
> UEFI tests. It copies a .seq file into the disk so it can be read by
> SCT.
>
> It doesn't seem to work and I am not sure why. I am posting it in case
> someone else has ideas or wants to pic it up.
>
> Once Ilias' CI solution is in place, I can perhaps come back to this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   scripts/build-qemu.sh | 56 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 46 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
> index 0ff53593cf9..f9ee0072573 100755
> --- a/scripts/build-qemu.sh
> +++ b/scripts/build-qemu.sh
> @@ -21,20 +21,28 @@ usage() {
>   	fi
>   	echo "Usage: $0 -aBkrsw"
>   	echo
> -	echo "   -a   - Select architecture (arm, x86)"
> -	echo "   -B   - Don't build; assume a build exists"
> -	echo "   -k   - Use kvm (kernel-based Virtual Machine)"
> -	echo "   -o   - Run Operating System ('ubuntu' only for now)"
> -	echo "   -r   - Run QEMU with the image"
> -	echo "   -R   - Select OS release (e.g. 24.04)"
> -	echo "   -s   - Use serial only (no display)"
> -	echo "   -w   - Use word version (32-bit)" ) >&2
> +	echo "   -a <arch> - Select architecture (arm, x86)"

How about qemu-riscv64_smode_defconfig for RISC-V?

> +	echo "   -B        - Don't build; assume a build exists"
> +	echo "   -e        - Run UEFI Self-Certification Test (SCT)"
> +	echo "   -k        - Use kvm (kernel-based Virtual Machine)"
> +	echo "   -o <name> - Run Operating System ('ubuntu' only for now)"
> +	echo "   -r        - Run QEMU with the image"
> +	echo "   -R <os>   - Select OS release (e.g. 24.04)"
> +	echo "   -s        - Use serial only (no display)"
> +	echo "   -S <seq>  - Select SCT sequence-file"
> +	echo "   -w        - Use word version (32-bit)" ) >&2


A typical definition of word size is:

Word "size" refers to the amount of data a CPU's internal data registers
can hold and process at one time.

I.e. a word on a 64-bit architecture has 64 bit.

%s/Use word version (32-bit)/Use 32-bit architecture/

Wouldn't it be the best to get rid of this parameter and just use
parameter -a with values

- arm
- arm64
- riscv64
- loongson64
- x86
- x86_64

>   	exit 1
>   }
>
>   # Directory tree for OS images
>   imagedir=3D${imagedir-/vid/software/linux}
>
> +# Directory for UEFI Self-Certification Test (SCT)
> +sctdir=3D${sctdir-/vid/software/devel/uefi/sct}
> +
> +# Mount point for use when writing to disk images
> +mnt=3D${mnt-/mnt}
> +
>   # architecture (arm or x86)
>   arch=3Darm
>
> @@ -65,7 +73,7 @@ kvm=3D
>   # We avoid in-tree build because it gets confusing trying different bu=
ilds
>   ubdir=3D${ubdir-/tmp/b}
>
> -while getopts "a:Bko:rR:sw" opt; do
> +while getopts "a:Beko:rR:sS:w" opt; do
>   	case "${opt}" in
>   	a)
>   		arch=3D$OPTARG
> @@ -73,6 +81,17 @@ while getopts "a:Bko:rR:sw" opt; do
>   	B)
>   		build=3D
>   		;;
> +	e)
> +		extra+=3D" -m 4G -smp 4"
> +		extra+=3D" -display none"
> +		extra+=3D" -device virtio-gpu-pci"
> +		extra+=3D" -device qemu-xhci"
> +		extra+=3D" -device usb-kbd"
> +		extra+=3D" -drive file=3D${sctdir}/sct.img,format=3Draw,if=3Dnone,id=
=3Dvda"
> +		extra+=3D" -device virtio-blk-device,drive=3Dvda,bootindex=3D1"
> +		extra+=3D" -device virtio-net-device,netdev=3Dnet0"
> +		extra+=3D" -netdev user,id=3Dnet0"
> +		;;
>   	k)
>   		kvm=3D"-enable-kvm"
>   		;;
> @@ -91,6 +110,9 @@ while getopts "a:Bko:rR:sw" opt; do
>   	s)
>   		serial=3D1
>   		;;
> +	S)
> +		seq=3D$OPTARG
> +		;;
>   	w)
>   		bitness=3D32
>   		;;
> @@ -105,6 +127,19 @@ build_u_boot() {
>   	buildman -w -o $DIR --board $BOARD -I || exit $?
>   }
>
> +# Write the SCT test-sequence file into the SCT image
> +update_sct_seq() {
> +	if [[ -z "${seq}" ]]; then
> +		return
> +	fi
> +	LOOP=3D$(sudo losetup --show -f -P "${sctdir}/sct.img")
> +	PART=3D"${LOOP}p1"
> +	sudo mount -o loop ${PART} ${mnt} -o uid=3D$(id -u),gid=3D$(id -g)
> +	cp "${seq}" "${mnt}/."

This will not work. The sequence file must be in Sequence directory of
the installed SCT and you must specify the filename when invoking the SCT.

To avoid instance dependent file names you may copy the user provided
sequence file always to the same location mnt/SCT/Sequence/uboot.seq.

Best regards

Heinrich

> +	sudo umount ${mnt}
> +	sudo losetup -d ${LOOP}
> +}
> +
>   # Run QEMU with U-Boot
>   run_qemu() {
>   	if [[ -n "${os_image}" ]]; then
> @@ -129,7 +164,7 @@ arm)
>   	BOARD=3D"qemu_arm"
>   	BIOS=3D"u-boot.bin"
>   	qemu=3Dqemu-system-arm
> -	extra+=3D" -machine virt"
> +	extra+=3D" -machine virt -accel tcg"
>   	suffix=3D"arm"
>   	if [[ "${bitness}" =3D=3D "64" ]]; then
>   		BOARD=3D"qemu_arm64"
> @@ -168,6 +203,7 @@ DIR=3D${ubdir}/${BOARD}
>
>   if [[ -n "${build}" ]]; then
>   	build_u_boot
> +	update_sct_seq
>   fi
>
>   if [[ -n "${run}" ]]; then

