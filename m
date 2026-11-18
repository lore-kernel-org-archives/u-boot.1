Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852E606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vDE1Ef1z;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awG/Btjd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4ED0080D43;
	Wed, 18 Nov 2026 15:43:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Koho_eaqk_Zu; Wed, 18 Nov 2026 15:43:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A67BA80C86
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795016626;
	b=J1GAR0UZLlSULN2nlnKauslnNy5O13HgL7Ic3pcxMdweh9T4KFh1ZTzir5UQMWsEzP8w
	 hy1+Jw+nxgjX+YPGCpaugcbmvCScJrgceyWToYtpkFEURmvjqKAIBpWkCqrnBgi5+fCbF
	 tE83P9bsQahds+5Ei/c17CoOUdLyxLh+43gzC97Jvf+sfi7nneunEtJHh33kqZuh1ZL7z
	 T3C/+iy1g3Og95XC5dUkvS7osMnyAxD6cfuyonoLDxCc1EtOLDOQoCkeHmoppX9JaWJTN
	 akb15U1zmCapU0GpX8I+g1RNEdJWFRH3IAx579REWE/56/UcQGyBqX9HCWL3aGVO7Mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wiD47Ex7f5qW7wbyvEhYV5BQlUywibtCVUIOyN5rVIQ=;
	b=jv6HgsXJlBmxpz/OvngoJ94oVO3T31aaGQqHceKTqEeI4+eQWHnZ0DtboseEpR26XK6a
	 cdzUnfCjuRwPeU2AYuAoijl93PrOBFPAKE0yCG1r9Xg0lXntlmWWQLcWWxKzYzdYogDlR
	 BA5yoNSPNZyljTu0/Zyl7JVBphzYkiEL/VbQRIPT+zmKHLm7LDiUrQFnlnAqr3xOwEIR/
	 DfyeP8EbDE7/Ab9SZSkvP+DHGwaqTZoUq/jR4ZZBHq9Pegr082zZ5dtbAIQfRXFxLo/QQ
	 u4LY+kVcxG2Jd3xSYhfpVnDoyVFEPRpmRxrPxQKgGmZ81X4C/ZkuQaze3OmfjuHAD4Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795016626;
	bh=wiD47Ex7f5qW7wbyvEhYV5BQlUywibtCVUIOyN5rVIQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vDE1Ef1zzMVexGkLydTAiINsY1MzmjEaUTqVwejf9TCGTyHU7E5H85YF14ITZvsLu
	 hXYsWuEw5zlQBgf4fV3CmFMPTY+N7NaIPKWvQP0iPlocdPkFYs+Cs/M05wZqWL4Iq+
	 Muhvx1gsUtBdj3GOYPSVZRdVNxPf2U5mG6oxxSaSkM29skhqVoyOTGWFCqXTtvCYRX
	 hhHkYTWXj7GDYBnm38hEq2czvUPy5cQtyKbuoBQg7YLvlL47D0aslJNHU19dxvN38k
	 DX0KHIWonDTLfxnvduYWiKQhpGLCqA5j2r0tDbf/RLwSGsZiWWNqw42OOiNdeMEIh6
	 DHnkeFhTPnwyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A67BA80C86;
	Wed, 18 Nov 2026 15:43:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DDBD428C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C424540A15
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXb-URyZ_VbW for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:43:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 372E840A11
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=awG/Btjd
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 372E840A11
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B277D401E9;
 Wed, 18 Nov 2026 15:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246B21F000C7;
 Wed, 18 Nov 2026 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016620;
 bh=wiD47Ex7f5qW7wbyvEhYV5BQlUywibtCVUIOyN5rVIQ=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=awG/Btjda8CI2pXjSIkrq8dI+RA7Prqt0siUppSpDAmFYeIt/K8SgT2cN+PDkW/TE
 MXN1P/ezJxChs+aRac/Cw9159XsRE83i7HpwMuvKGHun9mVjTTtHXsnFOu0hkSGXQn
 W4y6GNsAnxIhLv5/fpo8ALZHEJefSodCMKJov8FeoP00cFrKUNR1H0/1ug1L/WNL+x
 RjbRsGaN1BFvm2ZGHhAQhKdjUReVDk66H4q57IQeThhKJF6Yx+wLpGS5x1yF/WOPA3
 h/U9VtOuGu4HGaBiKy2in6AayKw8bSMrRu/wBwqjyh+5uChxG9nl1g4Tnp1YAFMLLo
 lvPcaCvUiIsmw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/5] test: avb: test the hex persistent value commands
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-2-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-2-9177277458f9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:43:33 +0100
Message-Id: <179501661322.306911.15624120042540496078.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=522;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=F8xaZdS5X6Dt3sabOJKy/C0gMBBKD/1kNYrblIBtkGQ=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/cen+L34JlgA3mwJVJ13Hq95K9SkxcbphbB8K
 +DFTSU1oFCJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav3HpwAKCRAZDR20Zk4Z
 NXM8CADbmIvL2yfjv3MVXc/6fXe8w9aBkl/IoHEXWTLQQ3Wkx4cfeHjMS0ZS7wjQ1yImh0AaWgZ
 2D3zKRCHQRljcCp0iXQI711ZqQvlwbLVCqTTo9Q2HShMmmU4KFgM6rifPV7LfqEMa7QgxeuwUJ+
 0g4SjF1QV6QqLGCdcCTnuyEkeg1FqiV5IBdEja2dQ4C9jShaiHduIYInMTGfJA8P6rtDkUZCi+t
 6KT1ntb6HnTgVzdzqQWGAStUmbn7H/LZwVfb2Uff6wYnbDbVUFmJD6wXLJAdVdMeEe2NgW89EZ1
 nxAQZqJgF7I2ES/A4Aylx4LouEFWt48ZvpMc9XhZu/K7pPOF
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 13:52:50 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> Persistent values such as the digest of a user-provisioned root key are
> binary and may contain zero bytes, so they are written with
> write_pvalue_hex. Test the round trip, that string values read back with
> their terminating zero, and that malformed input leaves the stored value
> alone.
> 
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
