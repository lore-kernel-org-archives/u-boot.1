Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7790FC9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 04:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFE6040578;
	Tue, 29 Sep 2026 04:48:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPO81oAHmxPB; Tue, 29 Sep 2026 04:48:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7D36D40541
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790657326;
	b=hb15ZPGD9B1dkxF325PExCZduLL4uDnBsafgjWExkh+5kblC5qCZaZWGzZbyjB47CmJY
	 DR3q8p+P4seYuQ17w39RKGd0SH6TZYq8fDAXpD2tnvMVpVKgKFx/ysu/GcbrPHbSIQbxy
	 OUNSoKJK3C4rTzR3AxHFinUKBglfmMrxdmtpuQnnDaa14UFbBYgP4z8rjwwKe1vXlC5Sd
	 IQ/zzYC9xEi9H5xBaLGkhQ7taT+kZHFuT0RoBUixohdyd6q6vCAMzx/EhShgJieRIL91m
	 Cw7Qx4f4MrES/e9emPp04lU8Eky7VZshFHG7RSZPjxUCRCfZ4h5P6ST5BPUG8v71x3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790657326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cZZ1IRaO3r4UxHTjYsdMczFPdZybLSkSu7BvXnbXLj8=;
	b=qAFV6VCJqHROIKUMZXn3Zc0RSIys42AFsUEu/WSlhSh7Hkabrfq6CMcap8XQRzh6LM90
	 56oHjIXsdVKofIGk20JdWAh+OW/xLmiROrXJ6OTd7uW78TQVBHFb+3jpZO5XQCnAwDjnK
	 98DQ/6pSr62KpTCcS5ePOVyj5r95NitGtxcU3oNv0iENJGwOyGaz85r7lNockIadrJvsz
	 Qt89FAxI0W8eyrzRSkVl0Y/bTgp9rr7fz7xbjn0u5ca1PnRxWz6MWg5V4Apkrvm1g/ysp
	 3+kINiB4dDHqybB7MKaPHz/uTyMEpMhOU87LP+uxI+ixs5cFshbtEkYRnq5Ka1cN+5Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790657326;
	bh=cZZ1IRaO3r4UxHTjYsdMczFPdZybLSkSu7BvXnbXLj8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DN8AdbfjMlrvCZDtZudLLiaSODm3Ntz3UF7QHRJjcoSjbFCFzss2l9b5c3MZGknD6
	 yGswX4KYns7ypjw+hNItJsu8FDykUfT2Y+/EkuIC6s6DwuMBuPSuZ1yI9GyeKmF6Lo
	 KC0tqQZmNGQFz1bNvNaNnNrTXp/g8QCxF5xLfmbuyKj0zkyYNEVVuhxuGfHYJ/0r8R
	 ouJQ/5ow8xJVfm0/JxYkbOW3NJwOL+bx+ZeBRlIQSSwhaVip4sNnDhZLot+SI5Eioy
	 zXJ8bNDQC7jEb1W1gnHT+j79OGkXZwlK5QLHb8ayindjM4w0698fy6nTOzomSsXZnD
	 OMR0wn0KCFb4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D36D40541;
	Tue, 29 Sep 2026 04:48:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD38461
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2C3180BBD
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wJPMNPKH18PV for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 04:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 14CDD80BB6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.82
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790657324;
 b=kuhBBPy3B30f33bujdJi5yAKdvYTuUY3iwYNRUCHpp9IGkDbc/qEjTqiAoYIEEWfRAbs
 xld7uvHAodyIbp9IxKBT98/JlS/GihSOE9XPyrzoLIuNl5WkVSJjOb5J/wP6A9/Pg0aIE
 wB75g0Nr1J6c+n46462ipk5ez9tT6r1MY/pkXLfMGj8q3ntDFJ2FW8Y1jAG8X2qHnIGlC
 SVBKjFNpVn3Gw3KQDbZoFk8oESm6A/H1ut9kGkHFT08qotGM5DzNNGujqG1DXx37GMhrr
 ageZvbGuVTJmVIKzWnPH4Dqv1T6vj/8mDHaRKimI3Ds3av+gTtwYWWTRRLGdB70u6wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790657324;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=cZZ1IRaO3r4UxHTjYsdMczFPdZybLSkSu7BvXnbXLj8=;
 b=WlNq+MVkzyOVgIx7jXWqn0pNnzGEfV2jhX3fGKNSfP5+AVOWTKPfwizm8cLn3VzHxkPP
 drlcpyu6DmLe2//Z5bwsnyD7U9OBan/l0HYRqHE7h46JEpTi+PjSup8iQhp+6W6NvPNOy
 QX2vzf4FAGQ+DuPYoSwloT+IXzLZmDytw6bbotk6IzePfD23a8GDwPPdbw3Gg+zE/ZJGx
 f2WXi/+lhpVp+fx67HP2/mL4+m4ZgBjMGCCGCYBS0wt+gtUFlObAc1EWgaPgDiuJ2utAA
 CID/vM1rdPZ7zP5pJRUu1ctmVVAok34fXk9Aq78NsWRgYC4by/MZTXUtu0H0kpMQdVQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=fwobGoe2; 
 arc=none smtp.remote-ip=178.154.239.82
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.82;
 helo=forward502a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=fwobGoe2
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net
 [178.154.239.82])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14CDD80BB6
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:48:40 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:4403:0:640:bf85:0])
 by forward502a.mail.yandex.net (postfix) with ESMTPS id C09CE836E2;
 Tue, 29 Sep 2026 07:48:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id WmZmtZticqM0-d9nPcTIk; 
 Tue, 29 Sep 2026 07:48:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1790657315; bh=cZZ1IRaO3r4UxHTjYsdMczFPdZybLSkSu7BvXnbXLj8=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=fwobGoe2kDGsOJgpbFdPIGSBLsS/cByQdxf4EJdne+dxknVS8CxSxIyaiGDAiCW56
 +f0L4ZHprp4THEEodQf5JkuUwReSHEUoopx2qFYZNsvCyY2tRkwVj5e8Aa+h1kjkKK
 e4JO6DNzY2EAgmc0o9wYgN2w7NrBe5GPX3Ykubds=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <4f4121117eb212454498a6fe01d9ceac1d13e0b4.camel@maquefel.me>
Subject: Re: [PATCH v2 0/6] RISC-V SPL: fix OpenSBI FULL FIT loading
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Aristo Chen
 <aristo.chen@canonical.com>, Francesco Valla	 <francesco@valla.it>, Anton
 Ivanov <anton@binarly.io>
Date: Tue, 29 Sep 2026 07:48:33 +0300
In-Reply-To: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Simon !

A gentle ping on this series.

Thanks !

On Wed, 2026-09-02 at 09:31 +0300, Nikita Shubin wrote:
> Hi all,
>=20
> This series improves CONFIG_SPL_LOAD_FIT_FULL support on RISC-V,
> primarily to enable loading OpenSBI as firmware and recording
> loadable images (e.g., U-Boot) into the FDT passed to the next boot
> stage. This aligns spl_load_fit_image() with the behaviour already
> present in spl_load_simple_fit().
>=20
> Patch summary:
>=20
> 1/6: Allow IH_OS_OPENSBI in fit_image_load() so OpenSBI firmware can
> be loaded without error.
>=20
> 2/6: Enable spl_load_fit_image() for RAM boot when
> CONFIG_SPL_LOAD_FIT_FULL is selected.
>=20
> 3/6: Use map_sysmem() for FDT address handling to keep the code
> sandbox=E2=80=91friendly.
>=20
> 4/6: Initialize spl_image_info in
> spl_test_load()/spl_test_load_fit_full().
>=20
> 5/6: Record loadables into spl_image->fdt_addr during FIT load,
> providing the entry addresses needed by subsequent stages (e.g.,
> OpenSBI).
>=20
> 6/6: Add a unit test to verify that loadables are correctly recorded
> in the FDT.
>=20
> Tested with provided sandbox test with a grafted FIT image containing
> OpenSBI (firmware), U=E2=80=91Boot (loadable) and a DTB.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> Changes in v2:
>=20
> Addressed all review comments from Simon Glass:
>=20
> - Patch 2/6: common: spl: ram: Add LOAD_FIT_FULL support:
> =C2=A0 - Reworded commit message to explain that FULL parser is needed fo=
r
> full image verification (CONFIG_SPL_FIT_FULL_CHECK)
> =C2=A0 - Added fallback: if spl_load_fit_image() fails, try
> spl_load_simple_fit()
> =C2=A0 - Mentioned fallback behavior in commit message
> =C2=A0
> - Patch 4/6: test: spl: Zero spl_image_info:
> =C2=A0 - New patch added to zero-initialize spl_image_info structures in
> tests
>=20
> - Patch 5/6: spl: fit: Record loadables to spl_image->fdt_addr
> =C2=A0 - Fixed typo: "lodable" =E2=86=92 "loadable" (subject, commit mess=
age,
> code)
> =C2=A0 - Replaced -1 with FDT_ERROR (from image.h) for missing entry poin=
t
> =C2=A0 - Moved FDT size adjustment before loop: use
> fdt_shrink_to_minimum() once instead of fdt_increase_size() per
> iteration
> =C2=A0 - Extracted duplicated code into helper function
> fit_record_loadable()
> =C2=A0 - Replaced debug() with log_debug()
> =C2=A0 - Removed backslashes from debug string concatenation
> =C2=A0 - Added note about gd->fdt_blob limitation in commit message
> =C2=A0
> - Patch 6/6: spl: fit: Add test to check loadables
> =C2=A0 - Fixed typo: "lodables" =E2=86=92 "loadables" (subject, commit me=
ssage)
> =C2=A0 - Removed unused variables (uname, str)
> =C2=A0 - Added FDT size fix after fdt_finish() to prevent external data
> offset drift
> =C2=A0 - Replaced #address-cells =3D 2 with ADDRESS_CELLS macro
> =C2=A0 - Replaced fdt_property_u64() with fdt_property_addr() for
> entry/load properties
> =C2=A0 - Extracted duplicated image node creation into helper
> append_fit_node()
> =C2=A0 - Fixed assertion: ut_assert(noffset > 0) instead of
> ut_assert(noffset)
>=20
> - Link to v1:
> https://patch.msgid.link/20260807-riscv-full-fit-support-v1-0-21a34f79c35=
0@maquefel.me
>=20
> ---
> Nikita Shubin (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image: fit: allow IH_OS_OPENSBI in fit_ima=
ge_load()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common: spl: ram: Add LOAD_FIT_FULL suppor=
t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spl: fit: Use map_sysmem() with buffers fo=
r fdt address
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test: spl: Zero spl_image_info
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spl: fit: Record loadables to spl_image->f=
dt_addr
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spl: fit: Add test to check loadables
>=20
> =C2=A0boot/image-fit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> =C2=A0common/spl/spl_fit.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 66 +++++++++++=
+-----
> =C2=A0common/spl/spl_ram.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +++--
> =C2=A0test/image/spl_load.c=C2=A0=C2=A0=C2=A0 | 184
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0test/image/spl_load_os.c |=C2=A0=C2=A0 4 +-
> =C2=A05 files changed, 250 insertions(+), 24 deletions(-)
> ---
> base-commit: cc8c034e78eba6b2a3845783889b80753bb1af1e
> change-id: 20260731-riscv-full-fit-support-320d38f8311e
>=20
> Best regards,
