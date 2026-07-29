Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EB1C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 17:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 500B3406D9;
	Wed, 29 Jul 2026 17:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qD29DjQ2nVwK; Wed, 29 Jul 2026 17:07:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50A95406DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785344860;
	bh=1T0r1NFHb952isGZjYTTxZnRlbil+slMAmAIxcqmmr4=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ruulqar/BLhKJXTND2nzPadvo73316T5jNs0xGcr7hUuo8o/tafJvwv+J+W6s7WIh
	 3q7UBLGZIEtMhT8hvj+rNlfhpOHXmf3Ckce/LTGnmoVcIdFDt7v4DkoLpBub7LHLwU
	 20ChiE/w74DK7P+SPI4df3G3eQW3txbUM6mL4MjVmeUnpIX7hVM2SCImmb8JmnRNtU
	 oddI3ktVI9vvf0rk/PZxDe6UJI7lrcAfTuXzLO4sAAHIAKvhpcDfJGtaC8COURaHxp
	 tzLnLIaZYFiMMjZprAJGYhfnnaerRQ8ldB/fTVaABKULaLDWQ241We+D9hJqXyXdWu
	 qw2xq8FnPRk0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50A95406DE;
	Wed, 29 Jul 2026 17:07:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B41E43B1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 17:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A58034009F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 17:07:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JyfvJ4TYqaAm for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 17:07:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 799DA4006E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 799DA4006E
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 799DA4006E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 17:07:37 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4a4cb36ae00so689039b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785344856; x=1785949656;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1T0r1NFHb952isGZjYTTxZnRlbil+slMAmAIxcqmmr4=;
 b=sDMYWrgTY6vlfvVMmuxlXwk2KKhvMHAcYYm6RucVycmdK0G/V4hxEO1rHu5m6nNyGJ
 0JVEj7FU2LxFiiAGKQHHavcqDBFF57tqjoSB/AKDZvtArDw6IXjCmCDRL9vhd31nH3oe
 UeUO1XsUFb9meREvjpeJ9JbgPzQFdqvUkNq9xTGv3O55Izx5MIfd/rSbv6gQtEY2yB5g
 BMDRT2CEUy4srwq/gc7l2Xggo2v4JA02zmz3SYlaI79BBe2+hQdZyIfEpJ/NG7YODlwB
 1SSzQd682VkYxq2E1W7DA3b7+M7ELKU7gyA2OZ5IFC6KBcNh9x0d/BBHG4hOBlgMm1zr
 l76g==
X-Gm-Message-State: AOJu0YyqFE803VUGoKEUgD/pmNO90JtpKXergWGk062v7aBmPjT2WGah
 78mlaNNVb1aVBjrSOL0l4pJYYPZIF5sAfCs97NIQsIum5Tb5ZiaZul5NIOnjmr3eJkwYU6XYpGz
 SvsLZpIQ=
X-Gm-Gg: AR+sD1185xHefMLlKRN1b+I7zjFq3vUeqDt1vkJxrBrNJlJJpWDtQ1Np3iGNhIe0Zxa
 xdOSILlVnGD+vUwPiZlZICbsokGuvcG+g54cy4s831+Luauwm5OX/57WOrEdjyK3V/FVwrQjIvV
 74atGfWlIeYd2Ios1oFw+4iNCMnJWwBGzEtKgem09ZMcNsTQiIzWaoGnFRq5RtqfFbHfGqiZPt/
 VhCbfGCl6MogmuqwY6ac9dgcuYYFyiR5knTSrAt52QxKIpE+tBEznLVPqbTj2eWDpyvAY26GwSk
 GCznz18JDu+LSZ7UEvbi3SrlHHt/1B4dcOOnJtoPpdbTuQVuVYUlJ+BvTaDVFImj5WU9gIUTCEg
 ON1u3A7kz+asLXvHN3Kx70eMBe4DsVuU19KaGpMMjPfA5EQ4qpiTlkQqhsuth1ooSgh33gkjoSs
 rWoBsScpjS5Q8v6BaeEnBtV9fe9tufX6U3nAI70iQps6VXjarWFpfl40WN+KHytzuQLma2O7B6S
 EsLfhN8CRWm4SmsJ+JvInSgc41GkEOvQuNjObMjuryNjmpqyr5h2W9dPGwKBA031uHyqTuPoXNH
 0d24HrWVJQ==
X-Received: by 2002:a05:6808:179d:b0:4a4:dfff:2daa with SMTP id
 5614622812f47-4ad5bb23656mr3839289b6e.20.1785344856360; 
 Wed, 29 Jul 2026 10:07:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6ef5cb23sm2192906b6e.11.2026.07.29.10.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:07:35 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:07:32 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Pranav Tilak <pranav.vinaytilak@amd.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260729170732.GC1773261@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="65VTsrMRCKEnFLwy"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785344856; x=1785949656;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1T0r1NFHb952isGZjYTTxZnRlbil+slMAmAIxcqmmr4=;
 b=osAXCzjkIHtNtLH2COSHnXVgU9ifoSlR5FkQCCfhEA3T97hgZW2J+dWc8KJ8xJTG2F
 4HUgFCL/j2ox9iF9S/6TKa3YIc0PPXI1ougeB6AUWklvBexCSBsteOC+IXe/vvL9Df7J
 VOIVdOYIG5sgK0RS2f/0XubpeeBXMWj74sE28=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=osAXCzjk
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--65VTsrMRCKEnFLwy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Here's the scan report for -rc1.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Wed, Jul 29, 2026 at 12:06=E2=80=AFAM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 6
   - 5 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 6 of 6 defect(s)

Defect Details

** CID 651722:       Error handling issues  (CHECKED_RETURN)
/drivers/power/regulator/pmbus_helper.c: 48           in
pmbus_regulator_get_value()


___________________________________________________________________________=
__________________
*** CID 651722:         Error handling issues  (CHECKED_RETURN)
/drivers/power/regulator/pmbus_helper.c: 48             in
pmbus_regulator_get_value()
42     	s64 uv;
43     	int ret;
44
45     	ret =3D pmbus_regulator_select_page(priv);
46     	if (ret)
47     		return ret;
>>>     CID 651722:         Error handling issues  (CHECKED_RETURN)
>>>     Calling "pmbus_read_byte" without checking return value (as is done=
 elsewhere 17 out of 18 times).
48     	pmbus_read_byte(priv->i2c_dev, PMBUS_VOUT_MODE, &vout_mode);
49     	if (pmbus_read_word(priv->i2c_dev, PMBUS_READ_VOUT, &raw))
50     		return -EIO;
51
52     	if (priv->info)
53     		uv =3D pmbus_reg2data(priv->info, PSC_VOLTAGE_OUT, raw, vout_mode);

** CID 651721:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 651721:         Insecure data handling  (TAINTED_SCALAR)
/drivers/core/ofnode.c: 134             in oftree_new()
128     		/* register the new tree with a small size */
129     		fdt =3D malloc(size);
130     		if (!fdt)
131     			return log_msg_ret("fla", -ENOMEM);
132     		ret =3D fdt_create_empty_tree(fdt, size);
133     		if (ret) {
>>>     CID 651721:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "*fdt" to "dlfree", which uses it as an =
offset.
134     			free(fdt);
135     			return log_msg_ret("fla", -EINVAL);
136     		}
137     		oftree_list[oftree_count++] =3D fdt;
138     		tree.fdt =3D fdt;
139     	}

** CID 651720:       Memory - corruptions  (OVERRUN)
/drivers/i3c/master/dw-i3c-master.c: 809           in
dw_i3c_master_attach_i3c_dev()


___________________________________________________________________________=
__________________
*** CID 651720:         Memory - corruptions  (OVERRUN)
/drivers/i3c/master/dw-i3c-master.c: 809             in
dw_i3c_master_attach_i3c_dev()
803     		return -ENOMEM;
804
805     	data->index =3D pos;
806     	master->addrs[pos] =3D dev->info.dyn_addr ? : dev->info.static_add=
r;
807     	master->free_pos &=3D ~BIT(pos);
808     	i3c_dev_set_master_data(dev, data);
>>>     CID 651720:         Memory - corruptions  (OVERRUN)
>>>     Overrunning array "master->i3cdev" of 11 8-byte elements at element=
 index 31 (byte offset 255) using index "pos" (which evaluates to 31).
809     	master->i3cdev[pos] =3D dev;
810
811     	writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(master->addrs[pos]),
812     	       master->regs +
813     	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
814

** CID 651719:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 651719:         Insecure data handling  (TAINTED_SCALAR)
/test/boot/vbe_read_fit.c: 136             in build_fit()
130     		return ret;
131
132     	ret =3D fdt_end_node(buf);	/* root */
133     	if (ret)
134     		return ret;
135
>>>     CID 651719:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "buf->size_dt_strings" to "fdt_finish", =
which uses it as an offset.
136     	return fdt_finish(buf);
137     }
138
139     /**
140      * place_fit_on_mmc() - Write a synthetic FIT to mmc1 and
return its blk dev
141      *

** CID 651718:       Memory - illegal accesses  (UNINIT)
/drivers/clk/spacemit/clk_pll.c: 42           in ccu_pll_lookup_best_rate()


___________________________________________________________________________=
__________________
*** CID 651718:         Memory - illegal accesses  (UNINIT)
/drivers/clk/spacemit/clk_pll.c: 42             in ccu_pll_lookup_best_rate=
()
36     		if (delta < best_delta) {
37     			best_delta =3D delta;
38     			best_entry =3D entry;
39     		}
40     	}
41
>>>     CID 651718:         Memory - illegal accesses  (UNINIT)
>>>     Using uninitialized value "best_entry".
42     	return best_entry;
43     }
44
45     static const struct ccu_pll_rate_tbl
*ccu_pll_lookup_matched_entry(struct ccu_pll *pll)
46     {
47     	struct ccu_pll_config *config =3D &pll->config;

** CID 651717:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 651717:         Insecure data handling  (TAINTED_SCALAR)
/drivers/power/regulator/pmbus_helper.c: 285             in
pmbus_regulator_probe_common()
279     	int ret;
280
281     	chip_addr =3D dev_read_addr(dev);
282     	if (chip_addr < 0)
283     		return -EINVAL;
284
>>>     CID 651717:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "chip_addr" to "i2c_get_chip", which use=
s it as an offset.
285     	ret =3D i2c_get_chip(dev_get_parent(dev), (u32)chip_addr, 1,
&priv->i2c_dev);
286     	if (ret)
287     		return ret;
288
289     	priv->info =3D info;
290     	priv->page =3D page;



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--65VTsrMRCKEnFLwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamozUQAKCRAr4qD1Cr/k
CvMgAQCiZpiaLRRWjmgb2TMSg50gRabVCnHy9nGJ3WkecVbpAAD/S2w2D4GbHMzI
80skMwMmaqn539YJyvm8NCpvAFimnwM=
=se2X
-----END PGP SIGNATURE-----

--65VTsrMRCKEnFLwy--
