Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AD2C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A583B4086A;
	Thu, 13 Aug 2026 16:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id THsXKRS3G9gJ; Thu, 13 Aug 2026 16:36:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFC0140879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786638983;
	bh=x4kL8PDh6T/6gPqLmOyMlTEn39QWDAnqLL68JJzf0Uw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wN4ys/R30tc3LhI5EgXWFwRXOiy/QEMy3gtTNk+CZVGxmwldmY7AOQvLV1BO059Mu
	 x2tp4hnagTDfxuF/dDDJ6AhVjnp7fLvZoa8j4PNFxN7chaQWXU3D9yQ59mQF2Cnwad
	 rqDRlpjNT45iIEleAb8L0iApM2FPUSfaXL5e9NsdSTm2tHmxxyJwYa5aZyhVcTRQNU
	 vHA8PvN1mqsdd2SoiXmGWOZ2b6+kH9Pq0DHy+dbrTYHD+Y1Qs9BBIcrvyXNAk3nwAB
	 8MNXcbNEdYBLenC7fBUYKa9Gxzajbbu5IjAQosL+2SibxuU+YPnDoPUJUhG8yqQPya
	 Y/lbFQwIwBi5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFC0140879;
	Thu, 13 Aug 2026 16:36:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 11D813A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04226811FF
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eRnkFAzYveA8 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:36:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0FDEF811B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FDEF811B3
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FDEF811B3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:36:20 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6b049ea7a4fso41992eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638980; x=1787243780;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x4kL8PDh6T/6gPqLmOyMlTEn39QWDAnqLL68JJzf0Uw=;
 b=CONo6u0oCeqOeGftorZa5PbL0KVHAqQ/fOu7pP10xwZfK2eb1M9HOUBnTzperbwV6j
 FvwDyETXHqs2TfLTUUN3T90pZ6k74ONeg+elEQC97GN3WqjTbX+wGx3eb32hsbjMcf4C
 sYgQC0TxMIgwPuvbDM07CbKokmzEG5gHQhqZJgxS3Kzk/3bpDasYQEnRtlYcodev+c3u
 alXA2tLGWjCvJyVDuCIWEyKa1Q7szP3MM0yTBmgO5lKVRZt13z5mj28xa48hmdQ/53ml
 QVTGDtAqk1iCroNam4egsIghyms7FJG4TjiPGNffgxLkjedYfIrgl/PdF4rHc6qirsWJ
 Vdxw==
X-Gm-Message-State: AOJu0Ywcossuxj/RRE8p+L/OHsCBYSf2ovKEr6O0oEEOTy18+9cLbD9R
 Sefx0bVkjevL4M2NDYJoQUmoV4e7EYNuCCPJNVPXgrcOBLdqkVOLr92GmTRjnroTd5s=
X-Gm-Gg: AR+sD12BQd3sBCYuVIOdJ/ZYsNcUe3C3B8g+EjnOmCnPVsbiW79s1zzVOT5xsV/QBrm
 5T08Er1E0iu8I8kToyeTWp2TsMPOyN7uE8advJZZDNx1B8oOCFB/Yxf9zzh8wVDPMK6TrxklDlN
 0fMmzmkB7zMCOUQgx/uUthEgMqwVtKomxI4xIJzRKYE1fk9CnT3zgPfaFCVtn03T1xk1OeRNeTk
 1bwwhrP56S5WIqvxv8+Gkoqem02nv279dJLRHp/Sr78fw3YBx2yIksTYvoNelNZgI2W7/SLzp9N
 ARzGgghn3JEAKk39j1mRyyMlNS0Bfqp0Gm8f7dL80aRQCYt8J6UWRCdxc5AvXLv5o6wgwKpo0gr
 PxKt1I2miNgkQdd+BtNU8Y48SQjvfAOeIi7NOKCquEbLt9q3tnbRD4ueNLFS6d9UoiA+es63vb0
 YvkFEyzZhF5RdeMTJaTlFMRvcp+li2WR4gVfqumPdutFqe2eoxVWHiZlKpj+ghU+NixePEqZjum
 5g=
X-Received: by 2002:a05:6820:2915:b0:6a0:f319:6903 with SMTP id
 006d021491bc7-6b0c41955f8mr6169735eaf.6.1786638979864; 
 Thu, 13 Aug 2026 09:36:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3678:ac91:e955:c25])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c3d6c29bsm2839734eaf.0.2026.08.13.09.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:36:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260731-mtk-mach-phase-aware-reset-v1-0-90b918aa52f5@baylibre.com>
References: <20260731-mtk-mach-phase-aware-reset-v1-0-90b918aa52f5@baylibre.com>
Subject: Re: [PATCH 0/2] arm: mediatek: use phase-aware PSCI reset
Message-Id: <178663896943.2270888.13433303041904971465.b4-ty@b4>
Date: Thu, 13 Aug 2026 11:36:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=689; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TLg3Piwzuze28BcSEH255qARn/nArAXVQqY3Bcw93cA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqffJ8iIgvPZe1U/absF4TElgmbbi8MWgL5sanB
 8zkYZG2z3SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan3yfBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASk4H/jXkvAF0cby7FzZLwx4HhIx1THUr/bUeaEmsRum
 Cj5OhkbR0+J9lhcg/gUrYDotdqetfbRaHdiPFtGlY2eaJgghJ2hxAG8B79ajk4E1MUq8WgLeZ+F
 QHdl+k9lyMDt2mJMUTpZSOqN5INAsJ034Y/sVFzAzRO4sMEppj0GiIgVGS41Qrd5avaS0hHBMMt
 7e03YE9dqNUF2bX3RfeV9QSA27P/ozS8zRe5bIXRl6S0nVefvL0GF2slk2pIiC7yY3PbmFazvqq
 GBE0uQ8EoZxp+c69mLSvYR414JoLdo7wev6dOX34gOtuwMJm4dgyr14DhZEERfVHWIHKFJAVD1S
 Aets=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786638980; x=1787243780;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x4kL8PDh6T/6gPqLmOyMlTEn39QWDAnqLL68JJzf0Uw=;
 b=lQPto9NjO2AW8SNzj7zCerScB7KjWNlf3z9LmCNScSFbbLe2PMlXULQM8Pn2IUR6Xh
 ZP4wZelZoZXjOBhZ+7qB+PEhMJVwe9SvE8e2wKzhgwxdB3b07augIN110QLW4bX6LWg4
 lSFICw6Kg3/meZbX+e6AWcHMvi/5shWM53xm5OutNhwNH6VzMXzpQy/GZnXMiOepV5P2
 sJPLgPShHr+9sDI6USAubeSpvXGcPcFak+RxSucTrBjwBnX5VjHdRtxuZIviHFXavMiJ
 FZlKO+tK0uhultyQkaU1ybZW3AgEsoYxZsCaCwTWAoOEFfSLAvg/+XTHrYc5Qkce+4B/
 mPWA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lQPto9Nj
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

On Fri, 31 Jul 2026 15:31:25 -0500, David Lechner wrote:
> arm: mediatek: use phase-aware PSCI reset
> 
> Similar to [1], a couple of other targets need to be fixed before we
> can enable SPL support.
> 
> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20260724-ccaione-upstream-mt8188-spl-reset-v1-1-08da6554ecd8@baylibre.com/
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/2] arm: mediatek: use phase-aware PSCI reset on MT8365
      commit: 81fdcc79c467ca42363091cab0e5dbb2282571d9
[2/2] arm: mediatek: use phase-aware PSCI reset on MT8195
      commit: 0bd564f4bbada6f10dc5aed31b09d58522ab3978

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

