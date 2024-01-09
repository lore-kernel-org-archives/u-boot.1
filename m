Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DCCC47079
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 17:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134278786E;
	Tue,  9 Jan 2024 18:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LhHThsG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 989628785D; Tue,  9 Jan 2024 18:09:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D78978786F
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 18:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704820158; x=1705424958; i=xypron.glpk@gmx.de;
 bh=dGP3Q2pD9NP0yyuA/iHLob20ZGzd/bkqE5QiQmQVdMU=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=LhHThsG4dUYASXEElpeP1Pj9ljCuBDP42Z5DeNiPhK2Vmkc+Yzn6NgiD3pT+H50+
 p6+3zYjHEk/AIyC+pfYXsvmID/CMbEnMEyvR36RVDBctu2SMP4S/iPndm2llrEn8f
 BUMXXYQjEf+OKPYtap6pTlZl0eSuTGnRBpe9DmCnydq1YDeSBCTXjgZ8TRKyaUTE3
 6lVbj/W3+LsJalT/5xWO3fXLzT1Z7ue7XkgOidzrwRf9lGzfxVzBXPM+MbxO+M4zI
 yHzt2izONVZYgWpMmfQ2Nn6YuzjRscbgMU/QJsNW98ABqYqyJRxsUaK0DbY+GXDX3
 bjKg86jrAGbZmUs0gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryXH-1qr9pL1XHR-00nxs1; Tue, 09
 Jan 2024 18:09:18 +0100
Message-ID: <10da4396-501b-4ab4-bd88-3d6c5b152017@gmx.de>
Date: Tue, 9 Jan 2024 18:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request smbios-2024-04-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:38rs1vlTecaO/uyoH3J6SoIs9btrdzWuuMs4eJgrNifbj2Mr8L4
 p5sJv3tsof83eqyc0SySbJ25wBxlvgSLTfWx9wpfMBi8YEaTsXpBHbE4MmBYAdkDiBjz866
 8Coh/sgk2R9UxIe1V+OtaA2MZTmJDzrh7hfj8DiIU8yzpkn1ovFKZ0gHiSfAkfMVD0yKEqE
 6ZNpBTIysu4VYeeHbllSQ==
UI-OutboundReport: notjunk:1;M01:P0:irJ9Syd03Q8=;auztr1baAHyMBXChGMV3ZDTerJ2
 ko8nHEGFE9JV10jDPL4+5zr92n11htnSo/FCfAF/+mXo5hYLw0LXKDU//GjFKZgKEhsfLMUZu
 i0hieHxUATj61p6Rboq196ZFqTVubFSqq4BQ9DKMNyWB+54DzbRGyHgKDMtcWHpgodWQ0xBb2
 1lMWuxfnsUMglIdaomq42YLDjyna/xTWWkip1FdRsCxWmbKNqtoC0iLpt/qQ3el0hGDHGlBbv
 k+mz94DsDw1hnT45gisV4ZC04F5UQepaLA+26D8lwrqEQhjbeKdc921tR7O7A8DAcU3mCCoUV
 Tpvau3MBcRNTNoPVcvcydh9CnUk+NoNCcRm/AQfZz18MJwjOnjYZt3p4HeVRU8S15Ehm8XaYu
 eILqMUQpiVjxnLxFQ6Z5mqETyp64gnyMzkCqlPkfH/etuPY98ZlBJez6JqStnAnW8v2G80b/R
 ARJUc1CqfL4R31akjBl7tQ9vG8DGOOF9jlPLjzePW6scrwXM08puPrrLsBPzMvx2pfAb7bzfy
 AFvBot4VA4y03PcRn/ynsNnFIxdpBlFLtWjmiS19k6WrCSeQ+A43DPOhuA/yBP0/uKxgvUULt
 9spz5fm8qJkoYSn8Y1DoJw7mXa6Cdo0eXJqnNv9zIjJq8kNRHpY6j2jm9Yo0QIficPIVosHYQ
 npOFQcb2h8KM7TLNXoC+E7emRuJLx4e971sLZCNuFLiMr2HgQtR0fkHbrRB66bQBl37ebBDNB
 KXIY4l616mIZfcrNkvx2pq6fMUf/df8NAliWfdHBbqMaqtrnJZnJLNHil7PlIMEnW6EOPCUN/
 o4zXqzm9icu2AmYBk8GTGws/1+vjfDnwULDub5ND7qDW/bKDoOMu57CmHORfzer2zO6vJtCeJ
 j9BiscQzqm+0oGY1WXWcJeVGmqwzk7sUrBX1unVl9vBFWNIQT3hy9SJD7fGUExC2PVmdB+nVE
 IpJLpNSJQ+rL10r9IMzWPgqixcEJTD9Ey5ZQwW8ZxN1wVbrklhzjriZg0pi5IX09li2aRA==
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

The following changes since commit c5e461fbf7cc72f0c1c8a79226b6a5170e56cb4=
d:

   Merge tag 'u-boot-imx-master-20240108' of
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-01-08 13:39:43
-0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/smbios-2024-04-rc1

for you to fetch changes up to 8aec7031112eba0dbfc8f23f9be11c081ea5cc56:

   efi_loader: provide tool to dump SMBIOS table (2024-01-09 10:09:15 +010=
0)

=2D---------------------------------------------------------------
Pull request smbios-2024-04-rc1

* make table_compute_checksum() arguments const
* remove duplicate function verify_checksum()
* enable setting processor family > 0xff
* set correct SMBIOS processor family value for RISC-V
* avoid importing ofnode.h in smbios.h
* provide a UEFI tool to dump SMBIOS table

=2D---------------------------------------------------------------
Heinrich Schuchardt (6):
       lib: make table_compute_checksum() arguments const
       lib: smbios: verify_checksum() is duplicate
       smbios: enable setting processor family > 0xff
       cpu: riscv: set correct SMBIOS processor family value
       smbios: smbios.h should not import ofnode.h
       efi_loader: provide tool to dump SMBIOS table

  drivers/cpu/riscv_cpu.c     |   4 +
  include/smbios.h            |   6 +-
  include/tables_csum.h       |   2 +-
  lib/efi_loader/Makefile     |   7 +
  lib/efi_loader/efi_smbios.c |   3 +
  lib/efi_loader/smbiosdump.c | 622
++++++++++++++++++++++++++++++++++++++++++++
  lib/smbios-parser.c         |  21 +-
  lib/smbios.c                |   4 +-
  lib/tables_csum.c           |   4 +-
  9 files changed, 647 insertions(+), 26 deletions(-)
  create mode 100644 lib/efi_loader/smbiosdump.c
