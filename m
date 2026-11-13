Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5BD606A899
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GoKXUkWg;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=GovathFg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3140A60687;
	Fri, 13 Nov 2026 19:49:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4VDnbnVbK-3G; Fri, 13 Nov 2026 19:49:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FDE8608B6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794599359;
	b=qSS/5do242dkEo7n1zPQp+M809xNFygriV+p2KmZH+q/nv4ZSs1ECEUmo3NPwasF6UYj
	 TW3s0XZA65MvkkAxXp6GlyNCzVecmizqOeTRUtLiRkSdtvZk4zrQ0KH0qdFN2VG2shgxg
	 AuZ8O/MRATsK9tFZS1KtrKjTSkSh897RI5hco90Jzp1BBW3LcmzmgOIYCzoqc+NcEEhd1
	 bifg1eN/jU/lYIwWo8TpDtifScxjzBBoWWJTUu5e1TaWJeY2P0TILYkqDTCQy04w46jDJ
	 dMRFbsAl323Z3dGiPGmwXU1hAjE+FdrFYU2vICefrO8YIt3eySJ5xDpAyToB+U5oX6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599359;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7pqiYYH6UsbC8pLI7vgUWKYLHzR3U5HiqezlLRVVgkU=;
	b=iKo7boeMhoN3SLcrQSimSlPdsIMHj1DeKrn/N1oa1BRo8EdPxJQ0ZmyipxV4wOJywhob
	 Qf9zu3NxrvY0CcQhD2LCLLDYsXE1MnkFAGIrk6HYDFdMCKqhRrLVvbwoaC0iD0fnxQ5LU
	 D+Pku+lI3iCFHh4pxecgmEGIz+jHr2CeHYxfjgnMUFG+QgjM8DhpqgiBPnuFNoq8qcZs8
	 MbRhZOKSUCwE1K5zlr5UtE4W3b3kUBHBUEwrcRmAeIel+zUyETT5GLtdXu7xOHC+C3cWQ
	 Z57JJQ4iTieyAPBEYgduw6b1KlSaeIO+VCtJKhhx4HgzrVbojp71UPURRlm2+mk9obw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794599359;
	bh=7pqiYYH6UsbC8pLI7vgUWKYLHzR3U5HiqezlLRVVgkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GoKXUkWgQlqRpoijeFEVQhRLAxm0rRVV5du1eLbRV8ZaLY6Jx3Kya/WQcZrMWPJwc
	 u0gQTvCW3fFwQS6buNU173n1sQo7ckr1NSAzQ+LSlrgD9gcMSdi/d/oj2Ni/SUJ8D4
	 dIq8+THmMyKjxqvFpWG4noFoxvl1zFoe/ofF62brkZDrGRpFY2KMED4kCn0UnxHHoS
	 4QkVebyTajLUYmDocWD45rH95B31R4j9ULh+t30CHe2nI7uQXYxJs++0VhyEqCp2bu
	 buaJZl5P8DMpP1D9eECUOnAazdsxD0I11oTcL+dPLqzc4xCJaC/PqayRcCny9AHmfd
	 KrHr88qUNq3Ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FDE8608B6;
	Fri, 13 Nov 2026 19:49:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB3D2286
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8B48817AC
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qNFqHVZpgE8M for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 19:49:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A00281799
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GovathFg
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A00281799
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:49:16 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-8439fe796ebso1774745a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 11:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794599355; x=1795204155;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7pqiYYH6UsbC8pLI7vgUWKYLHzR3U5HiqezlLRVVgkU=;
 b=GovathFgfjbvbjQdm3gvOtWZnAYPWqgw6oaa0jRtFQpkoc/uFoApb+/H2AwVmbsBVQ
 fbl6UeHlEju91sb7Dx+Wg+NNouiPR0ArSAOfQk64/3y4jTa+0l4istpRj+F/ZuiV6Y0o
 jPCcyRTydhhn27MgNyboEL3lDtMJu6WgAEZy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794599355; x=1795204155;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7pqiYYH6UsbC8pLI7vgUWKYLHzR3U5HiqezlLRVVgkU=;
 b=xypY4RdCFb8I+DGXqp1F2IbGdD1bhxB8UQz8zp2yx9dQmf3ujIuxre8ioGai7ZoPWZ
 DymQih8b/hCArC95FOMGcS4KtPjuMAYhH9ISbVy7Tsajz3ECXXcG4nvsOY3JqHb4UCPf
 OBMQfcdlgb5QJHSUloELZWBiJXyjnNYN9+SK4s3tP7w4p59irwkOWwMc7dX0yE06mPjR
 tcZ3vbVGt3lg61wS9KSmpXQu+OpqClr6sI9fzhVgDaRKYLAzO2ZEKb4KcnFeA6+xl0RC
 Bw7nnLGa+gEzN5G3iCSk3JQcRFfjxiGF7KFDao/JoOIt+oinkPgYCzLWqKThw2+OmNJi
 1biQ==
X-Gm-Message-State: APuU4Z9RhroIlOZdpPjnGzH93KAsYBdi/gdqULTRFN+5lrSHon9XI46B
 tgNwSzlX2N/jwUXesbrDqlLDH6dIAViX6m55h18D/vsIwFOG2nX4HQejGVB8v59gGF4=
X-Gm-Gg: AYBFou392KhCIjOiPTSjN92z1TfFrCqlI7uhRKKsFpcoBRkLteZx8rFikdV6bWxYC3/
 q6DWnq0b9iRMYboJrVPfT4TZQxquWDkXzsQ3Wcu0xmCOeHHlbA28JQYIJsDbhP0Kz+ozIwpodYC
 cKh9e0iCk7FBjzrGeq+99ilYPADEkFlOZ+zvx5LOIk11UqlI51TRIDWBYf3jCMBjhhGIWMWGzOj
 OnzQJLTM2zeXYEQ3XFh5AvKUQWFw+jnwlb6b2QHHDXBM6amDKkX6f8YunF97S/HqWX04YxsdSrZ
 8QEMyjDTad+90QoT1kpOqXtNHD4LDYdbGdvrMTGXxVkoefo8K0Fr+ed0d6ZDlGCOpeXpVtyP9Lp
 SRvhGcZx9XKN1p+VY7ognuw/XuIpJEhMS6WzZ9BKs+vWxyuvPk9Wa2zEkinSyE4FKRHDgOXNgK7
 CyyTb86/PfgP8l3eTi+j3ycEX71gN5dR5odhl3Eq1jRZpFSe8M7gtE29JZo6gtHyv1A4BlK2xns
 VvGwmACDDrmEsHKOL1NO5jw0jreOlIB5UZwldlxjbwsw+nI8G3xPat7KtFCQzPOAFixTSEL6DYx
 ofyMy9r4V9e/XQbCBnKOfxpDm6+apTUmd6ZWEcmt8f9wEWZ12e+1ALPB5MLqoHzSUGS6oa+KZf9
 nysTeRBfYI/2uUV2BCMJzc4b4pR0Qjgq9gj8SAd7pnXzQ3aAyU836lc9otm31XbyWdR0cAEW+3T
 /LU03okw8mgsosf/K9WCjYrY6iVLiASudLWmLMjTDLBWK2UdbHihUa
X-Received: by 2002:a05:6830:2309:b0:81d:2120:d5bb with SMTP id
 46e09a7af769-862898be7dfmr3721703a34.30.1794599354593; 
 Fri, 13 Nov 2026 11:49:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880a4e4csm3461944a34.8.2026.11.13.11.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 11:49:13 -0800 (PST)
Date: Fri, 13 Nov 2026 13:49:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>,
 Conor Dooley <conor@kernel.org>, Peng Fan <peng.fan@oss.nxp.com>,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/8] Add support for RPMI to U-Boot
Message-ID: <20261113194911.GP554944@bill-the-cat>
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cUaKV3FvJQq2CYFJ"
Content-Disposition: inline
In-Reply-To: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--cUaKV3FvJQq2CYFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 02:42:54PM -0500, Charles Perry wrote:

> Hello,
>=20
> This series adds support for RISC-V Platform Management Interface (RPMI) =
to
> U-Boot. RPMI is an OS-agnostic protocol for communication between an
> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. There
> are some similarities between RPMI and SCMI.
>=20
> This patchset first adds an abstraction layer for the transport
> (UCLASS_RPMI), then adds two transport layer (SBI MPXY and shared memory)
> and finally adds one client (or service group in RPMI jargon): the clock
> service group.
>=20
> This series also includes a sandbox mode for which the RPMI transport
> doesn't attach to a firmware but contains a simulation of a firmware. This
> reuses code from librpmi [2] to create the message responses.
>=20
> From V3, this series also includes the "mpxy" command line tool created
> by Rahul [6].
>=20
> Apart from the spec [1], this series reuses code from the Linux SBI MPXY
> driver [3], OpenSBI shared memory transport [4] and Linux RPMI clock driv=
er
> [5].
>=20
> This was tested on a PIC64-HPSC SoC which features an application cluster=
 and a
> system controller with isolated address spaces, hence the need for RPMI. =
This
> series can also be tested with QEMU using the steps detailed in the follo=
wing
> section.
>=20
> # Testing
>=20
> ## Build qemu
>=20
> Build QEMU using Subrahmanya Lingappa v11 patches [7] that adds support f=
or
> librpmi along with another patch (by me) that adds some phony clocks for
> testing. This is available at [8] for your convenience. You will also nee=
d to
> download and build librpmi since it is a dependency of qemu, any recent v=
ersion
> should do. The following commands do all of this:
>=20
> ````
> git clone https://github.com/riscv-software-src/librpmi.git
> cd librpmi
> make
> make install I=3Dinstall
> sed -i "s|\${prefix}|$(pwd)/install|g" ./install/lib/pkgconfig/librpmi.pc
> export PKG_CONFIG_PATH=3D"$(pwd)/install/lib/pkgconfig:$PKG_CONFIG_PATH"
> cd ..
> git clone https://github.com/ch-perry/qemu.git -b rpmi_patches_with_clocks
> cd qemu
> ./configure --enable-librpmi
> make -j8 qemu-system-riscv32 qemu-system-riscv64
> export PATH=3D"$(pwd)/build:$PATH"
> ````
>=20
> ## Device tree
>=20
> We also need to tweak a bit the device tree used by QEMU. This is done
> externally because we need to append a different fragment depending on if=
 we're
> testing M mode U-Boot or S Mode U-Boot.
>=20
> For M mode U-Boot, we use:
>=20
> ```
> cat <<EOF > overlay-mmode.dts
> / {
> 	clock-controller {
> 		#clock-cells =3D <1>;
> 		mboxes =3D <&{/soc/mailbox@10200000} 0x08>;
> 		compatible =3D "riscv,rpmi-clock";
> 	};
> };
> EOF
> ```
>=20
> While for S mode, we use:
>=20
> ```
> cat <<EOF > overlay-smode.dts
> / {
> 	clock-controller {
> 		#clock-cells =3D <1>;
> 		mboxes =3D <&mbox 0x1000 0x00>;
> 		compatible =3D "riscv,rpmi-clock";
> 	};
>=20
> 	mbox: mailbox {
> 		#mbox-cells =3D <2>;
> 		compatible =3D "riscv,sbi-mpxy-mbox";
> 	};
> };
> EOF
> ```
>=20
> ## Test RV64 in M mode:
>=20
> Source your RV64 compiler, build U-Boot's qemu-riscv64_defconfig and test=
 with
> QEMU:
>=20
> ```
> make clean
> make qemu-riscv64_defconfig && echo CONFIG_CMD_CLK=3Dy >> .config
> make -j8
> qemu-system-riscv64 -cpu rv64 -smp 4 -M virt,rpmi=3Don,dumpdtb=3Dqemu.dtb
> dtc -O dts qemu.dtb | cat - ./overlay-mmode.dts | dtc -o qemu_mmode.dtb -=
I dts -
> qemu-system-riscv64 -cpu rv64 -smp 4 -M virt,rpmi=3Don -dtb qemu_mmode.dt=
b -nographic -bios u-boot.bin
> ```
>=20
> `clk dump` should report 2 clocks.
>=20
> ## Test RV64 in S mode:
>=20
> Build any recent version of OpenSBI using the generic platform and the de=
fault
> defconfig:
>=20
> ```
> git clone https://github.com/riscv-software-src/opensbi.git
> cd opensbi
> make PLATFORM=3Dgeneric
> cp build/platform/generic/firmware/fw_dynamic.bin ../u-boot/fw_dynamic_rv=
64.bin
> cd ../u-boot
> ```
>=20
> Back in U-Boot, build qemu-riscv64_smode_defconfig and test with QEMU:
>=20
> ```
> make clean
> make qemu-riscv64_smode_defconfig && echo CONFIG_CMD_CLK=3Dy >> .config
> make -j8
> qemu-system-riscv64 -cpu rv64 -smp 4 -M virt,rpmi=3Don,dumpdtb=3Dqemu.dtb
> dtc -O dts qemu.dtb | cat - ./overlay-smode.dts | dtc -o qemu_smode.dtb -=
I dts -
> qemu-system-riscv64 -cpu rv64 -smp 4 -M virt,rpmi=3Don \
>     -dtb qemu_smode.dtb -nographic \
>     -bios fw_dynamic_rv64.bin \
>     -kernel u-boot.bin
> ```
>=20
> `clk dump` should report 2 clocks. You can also use the `mpxy` command.
>=20
> ## Test RV32 in M mode:
>=20
> Source your RV32 compiler, build U-Boot's qemu-riscv32_defconfig and test=
 with
> QEMU:
>=20
> ```
> make clean
> make qemu-riscv32_defconfig && echo CONFIG_CMD_CLK=3Dy >> .config
> make -j8
> qemu-system-riscv32 -cpu rv32 -smp 4 -M virt,rpmi=3Don,dumpdtb=3Dqemu.dtb
> dtc -O dts qemu.dtb | cat - ./overlay-mmode.dts | dtc -o qemu_mmode.dtb -=
I dts -
> qemu-system-riscv32 -cpu rv32 -smp 4 -M virt,rpmi=3Don -dtb qemu_mmode.dt=
b -nographic -bios u-boot.bin
> ```
>=20
> `clk dump` should report 2 clocks.
>=20
> ## Test RV32 in S mode:
>=20
> Build OpenSBI for 32 bits, the instructions are the same as for 64 bits b=
ut with
> an rv32 toolchain in CROSS_COMPILE. Build U-Boot's qemu-riscv32_smode_def=
config
> and test with QEMU:
>=20
> ```
> make clean
> make qemu-riscv32_smode_defconfig && echo CONFIG_CMD_CLK=3Dy >> .config
> make -j8
> qemu-system-riscv32 -cpu rv32 -smp 4 -M virt,rpmi=3Don,dumpdtb=3Dqemu.dtb
> dtc -O dts qemu.dtb | cat - ./overlay-smode.dts | dtc -o qemu_smode.dtb -=
I dts -
> qemu-system-riscv32 -cpu rv32 -smp 4 -M virt,rpmi=3Don \
>     -dtb qemu_smode.dtb -nographic \
>     -bios fw_dynamic_rv32.bin \
>     -kernel u-boot.bin
> ```
>=20
> `clk dump` should report 2 clocks. You can also use the `mpxy` command.
>=20
> ## Test using the sandbox mode
>=20
> Use your native compiler.
>=20
> ```
> make sandbox_defconfig
> make -j8
> ./u-boot -T -c "ut dm rpmi_clock"
>=20
> ...
>=20
> Test: rpmi_clock: rpmi.c
> Test: rpmi_clock: rpmi.c (flat tree)
> Tests run: 1, 4 ms, average: 4 ms, failures: 0
> ```

Once QEMU is updated, do you plan to update / add more tests, so that we
can run those tests, and presumably have more comprehensive testing, in
CI? Thanks.

--=20
Tom

--cUaKV3FvJQq2CYFJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavdpswAKCRAr4qD1Cr/k
CtyTAP4mhNz+4hgdVUWodxKDy0mSoSqXHHP7UtxNMSVfqadh/AD7BsR5JBPEgUX3
zt3r5bDKGjvy3ZeDtoK+C6klmRyalgY=
=YYii
-----END PGP SIGNATURE-----

--cUaKV3FvJQq2CYFJ--
