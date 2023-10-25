Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE30C25B48
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 00:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D368D879E6;
	Wed, 25 Oct 2023 02:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KPTOl852";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F055E879E8; Wed, 25 Oct 2023 02:45:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A5286EC9
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 02:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698194714; x=1698799514; i=xypron.glpk@gmx.de;
 bh=JwQfau0RTh5ArrCkHUNVSPzdqN28hPi39GZr9fQ0gQI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=KPTOl852xa/622a3b7bTbqjrDsfIptagN4kFELS0BpJo7cjwP5cTHfLDkrKguHMa
 bJvuePgJFqfecklyYMzA90thplaWZ+y9As7Ks+a9bnrNjNCGeSw0ZHVXzHUu9POPM
 PF/vpgc6coPyUmlI+bwyhsO5B6F7O1uPMIJMcYU4E8NJjNp5b5tAk4PipECbgDvXo
 0Qp/ALYZpub6+EUD+wiIC772LoIRIcLJEsAGgwipgrlKcfvNeZYgb8fMajXYppexK
 GX4QPt0MMlpkuuUSfpuAUvAyxN5VgFWAnHO7Dm3s7b5n9rqrfUY9WWuELTBktW64u
 fCuqClgPaZ8qYPY2Bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1rngdT24BR-00sLgu; Wed, 25
 Oct 2023 02:45:14 +0200
Date: Wed, 25 Oct 2023 02:45:11 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_smbios=3A_arm64=3A_Allow?=
 =?US-ASCII?Q?_table_to_be_written_at_a_fixed_addr?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
Message-ID: <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rd6TozeOTGuiiP6Y4fCneQqNc1/jKOG5jayC+Y6BHmLyQAwcTqb
 3V8X3doVBfmmx6JykJ7D2ZK/xm/rM7gRGd6XYoDCNtUj+WWCIr8bmWCkUaaDGbz8yqCBwsG
 Bu8V0zL6F7XGV7QdHkvYcM+F8EZE0T3Lchw12Au0srV+nzWCf0ndtSoZ0PZFzf2FoWz+uQM
 AD77UkdmfmQazJv4v3w+w==
UI-OutboundReport: notjunk:1;M01:P0:iCXGzpOKmuo=;3tnKHoXeYMzDDWD8e+o0rsEp28e
 iNatAnm72PPCyEteEfjCWgD7O3qtYDXdUOwIhlmKMh9eSiqNJrmEfT/u4NST2tJ8DVJQUo8VW
 fkBsAoN92eb8XqjjC4/gQrM8Rss42zj51eIKYWK3XTnpESeyNg8otakvuMl5EdZlckpzmgzK7
 LJFxDli8n1gHLI3TXLE2f9fnzWykArvqP+OeAcRdzg2HpiS2oFkomQTFvyTYj7vsq3zJ3SbJ/
 g21dS0/I5w66s8RbVrtxJLdKswRLPbBsjug7tKP6ww8UEM9qnF5siE97/2st6UQFDYg9u9svx
 Q0Ekgq30z0kwcBQ9nPXCS0Q9O7PA43QDj6AG/dEfB3NWDsC8oVd1CiZur3kXv/XRXyipgrOKD
 CXPOJAqR2sXNYx+6Frcn6r4Gk1ZxTGk7/uEgqL9anX2IuCgU9glSxRls4dmjSDeONlF7eAQeM
 M6Ex4BFdaAgi1L5WqKVxuHmxn0Xk+EBJvbbJSOItk+q2QXXJ5ympBnR67igZYxZmEw/2+5oO5
 EygcXx0+tFgMK3Wf2Z0XmygjryE3BxB05TCJ7n6uH0+6q/KC0cIZ47uMyqf+mRmTsIRnA8skb
 4N7sMDuiuNL5LpiWudwkdKWUAPsT1axgEcsei3RQvOxX2cHtvyOoAY03M1e38DJ7Am0Eiuxr0
 p78QDfHg7SOzl+MXMkj3DhE8F8SZuaewmnwhn7e7h5JAanaYewxzkLGdz3cpfK7BR5UU03mO2
 0LAt1WqTW2wo0amdozUoh4VkGKqMgdx30YSBU/upTpkYagdcD5hjbJy3R5lR67B6SHOndI28q
 VOI6sk6fp1Htk+AoYHanp4Xp/rei9eJSSml96vUpMeltqlHQS2tsNePnG113ayF/2VmAaGs8v
 YoIdZLL5gXweQ+uY2yWJGWX7TVs0aPACCzrClqN61g5ZN8Y6w2c3mqgzWELK7yKAc9yLaH6Xm
 UkXUVw==
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



Am 25=2E Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>U-Boot typically sets up its malloc() pool near the top of memory=2E On
>ARM64 systems this can result in an SMBIOS table above 4GB which is
>not supported by SMBIOSv2=2E
>
>Work around this problem by providing a new option to choose an address
>below 4GB (but as high as possible), if needed=2E

You must not overwrite memory controlled by the EFI subsystem without call=
ing its allocator=2E  We should provide SMBIOS 3=2E SMBIOS 2 is only a fall=
back for outdated tools=2E

Best regards

Heinrich

>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v2:
>- Update to search for a suitable area automatically, if enabled
>
> lib/Kconfig                 | 12 +++++++
> lib/efi_loader/efi_smbios=2Ec | 63 ++++++++++++++++++++++++++++++++++++-
> 2 files changed, 74 insertions(+), 1 deletion(-)
>
>diff --git a/lib/Kconfig b/lib/Kconfig
>index f6ca559897e7=2E=2Ea1eec98b392f 100644
>--- a/lib/Kconfig
>+++ b/lib/Kconfig
>@@ -994,6 +994,18 @@ config GENERATE_SMBIOS_TABLE
> 	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
> 	  the devicetree=2E
>=20
>+config SMBIOS_TABLE_FIXED
>+	bool "Place the SMBIOS table at a special address"
>+	depends on GENERATE_SMBIOS_TABLE && ARM64 && SMBIOS && EFI_LOADER
>+	default y
>+	help
>+	  Use this option to place the SMBIOS table at a special address=2E
>+
>+	  U-Boot typically sets up its malloc() pool near the top of memory=2E =
On
>+	  ARM64 systems this can result in an SMBIOS table above 4GB which is
>+	  not supported by SMBIOSv2=2E This option works around this problem by
>+	  chosing an address just below 4GB, if needed=2E
>+
> endmenu
>=20
> config LIB_RATIONAL
>diff --git a/lib/efi_loader/efi_smbios=2Ec b/lib/efi_loader/efi_smbios=2E=
c
>index 48446f654d9b=2E=2Ebdbce4c4d785 100644
>--- a/lib/efi_loader/efi_smbios=2Ec
>+++ b/lib/efi_loader/efi_smbios=2Ec
>@@ -47,6 +47,60 @@ efi_status_t efi_smbios_register(void)
> 					       map_sysmem(addr, 0));
> }
>=20
>+/**
>+ * find_addr_below() - Find a usable region below the given max_addr
>+ *
>+ * Check if *addrp is suitable to define a memory region which finishes =
below
>+ * @max_addr + @req_size=2E If so, do nothing and return 0
>+ *
>+ * As a backup, if CONFIG_SMBIOS_TABLE_FIXED is enabled, search for a
>+ * 4KB-aligned DRAM region which is large enough=2E Make sure it is belo=
w U-Boot's
>+ * stack space, assumed to be 64KB=2E
>+ *
>+ * @max_addr: Maximum address that can be used (region must finish befor=
e here)
>+ * @req:size: Required size of region
>+ * @addrp: On entry: Current proposed address; on exit, holds the new ad=
dress,
>+ *	on success
>+ * Return 0 if OK (existing region was OK, or a new one was found), -ENO=
SPC if
>+ * nothing suitable was found
>+ */
>+static int find_addr_below(ulong max_addr, ulong req_size, ulong *addrp)
>+{
>+	struct bd_info *bd =3D gd->bd;
>+	ulong max_base;
>+	int i;
>+
>+	max_base =3D max_addr - req_size;
>+	if (*addrp <=3D max_base)
>+		return 0;
>+
>+	if (!IS_ENABLED(CONFIG_SMBIOS_TABLE_FIXED))
>+		return -ENOSPC;
>+
>+	/* Make sure that the base is at least 64KB below the stack */
>+	max_base =3D min(max_base,
>+		       ALIGN(gd->start_addr_sp - SZ_64K - req_size, SZ_4K));
>+
>+	for (i =3D CONFIG_NR_DRAM_BANKS - 1; i >=3D 0; i--) {
>+		ulong start =3D bd->bi_dram[i]=2Estart;
>+		ulong size =3D bd->bi_dram[i]=2Esize;
>+		ulong addr;
>+
>+		/* chose an address at most req_size bytes before the end */
>+		addr =3D min(max_base, start - req_size + size);
>+
>+		/* check this is in the range */
>+		if (addr >=3D start && addr + req_size < start + size) {
>+			*addrp =3D addr;
>+			log_warning("Forcing SMBIOS table to address %lx\n",
>+				    addr);
>+			return 0;
>+		}
>+	}
>+
>+	return -ENOSPC;
>+}
>+
> static int install_smbios_table(void)
> {
> 	ulong addr;
>@@ -61,7 +115,14 @@ static int install_smbios_table(void)
> 		return log_msg_ret("mem", -ENOMEM);
>=20
> 	addr =3D map_to_sysmem(buf);
>-	if (!write_smbios_table(addr)) {
>+
>+	/*
>+	 * Deal with a fixed address if needed=2E For simplicity we assume that
>+	 * the SMBIOS-table size is <64KB=2E If a suitable address cannot be
>+	 * found, then write_smbios_table() returns an error=2E
>+	 */
>+	if (find_addr_below(SZ_4G, SZ_64K, &addr) ||
>+	    !write_smbios_table(addr)) {
> 		log_err("Failed to write SMBIOS table\n");
> 		return log_msg_ret("smbios", -EINVAL);
> 	}
