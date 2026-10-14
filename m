Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFBECC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 883C880FB1;
	Wed, 14 Oct 2026 19:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZ6LRrXbeMGz; Wed, 14 Oct 2026 19:59:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5D8880FB4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792007983;
	b=n50DJ+CcSlQTX2eR/n45UMS2LZePp96yldz4KFi7PEyoifA0GvLI+JegqCE3omA+HHA/
	 PqrUiju1gD5rkVilYYUgNT63Eu2N2y+xFY2x7xMytXz+bcM2O4oUdpkfSZKHUNadgYMxG
	 gPppiibtOMkCjRAV5ejdwjbMoFzT3ErQtT017FgmSMhbSpieMXQpYmhdHGR9hOk5B4urR
	 6LEwYZSNcp9ghbxmiB3l7aJsK7MDdfKlfNlZ/H27LfZph+xOxYEhhRMws/jlTbPvfh5X8
	 a7Bawlx5OMJCN0QCeikIbJ8I36uMZWyAgXsCjeO2+/wTha5TOJvqD0UFSCFjkljLh0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792007983;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ln2rZU0gjriKrZL/BQ5o3inHHBXjf8vwIS9ZY5vKPzY=;
	b=epqPVcJ1QTtsFV9KtjZTjLz1k+IgYhRkuf39W6FI313rNmZ7hDevLbDSFDVn/zc1bDfP
	 Xqn7wg63omjfXwC+oFO0ps+WJLZ5dtLGxj2GzJx+Gm1HqwS1RMz1nS0inqOaGKoz0qufq
	 4SHjN2y5F0C5n8mO44egA+q+UpzsZ0mt3VfGqRR1ToVkMur9J8mRdJxYAXIpl9xIInUpK
	 T72FmUj5XyWMbefXan8xJWzSse04ScO0lVsgw55gUHXibusM905w8uK7IqmzHfEtxmTwu
	 Oj0O5jbS731g5RV9nCQ9hl8/46NRIJa4v9+oRw/97YevjMwZtVZ5vZ8Dy03rAbyO9Ng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792007983;
	bh=ln2rZU0gjriKrZL/BQ5o3inHHBXjf8vwIS9ZY5vKPzY=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ERS4wx552tGEWIAJDG1ZotHsj0xqyLFLvCodxs7yn/eaVPFDBSeLalcg1liScSwG9
	 9Ryb2rSehN8jCFLzRWub3xyiYjdd+3aXpnTHfRDenCL6K8wAYbAyOkbuPdKxldpyWQ
	 QRtc6jkSquz+wutvjODFGXPAiJje/NZjuIpRV5B4lntR2CmVTr6DPu6r2E7cM2k9wP
	 1knv6Qeh2kLInKt/iWSsitOPunYhrHuwWaP0VU3fBxWye2o8NWmbTILMYabugFiJ4O
	 +qljZeAS67XUXEmv7kCWE+Rsx98NywTnZ2ZXwQogQS4rX385UsHVcdhyOkPIk7Dgnv
	 PPVol8yiRg87A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5D8880FB4;
	Wed, 14 Oct 2026 19:59:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 66844A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 558A540805
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbXN7dVcMYpO for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:59:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EED4C4075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792007981;
 b=qbt2SniREn6B8hKrLiF9lIB9PuWAe7E9xdt2vqFYaY/KdOdeNsqVukPcEQb9SxAco1m8
 7PlZ4EIodo3wLdda90MCDR68J1OSOBg2yMq2FyXAXJchYtOzabGjW69FPsCvTARKNS6It
 9a2++rIABFKWyZy4AuVvuI4jDPARGpgk6jLsrzx41DBBH+FVXJvSwGD0VRdUYjgWZBgY7
 Qepob7vSqI09EdenDhtvZ6J20uCjaS7oDNVR+vYqqhdmApSHl5iEv6T8tbEY4oPee/Di+
 65+P1UCC4eD5OMn3X0eRwWoPlCRwChVNy0FHByVrMi1B/q5b6GvGF3Lmbk7EzF73r+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792007981;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ln2rZU0gjriKrZL/BQ5o3inHHBXjf8vwIS9ZY5vKPzY=;
 b=eYgimf+rBwg4lmqyLkFsObQ0wlvcFihHP/viKkBl9x6nI+kVIgcSR/0ShGJ/59MOWu1k
 jfqK27zj/3ZIjS1jx1auGJMwQNbL/OzhmeYmEmB3yVvu6c/wWKXDWcUa9PRlVvTm8GGQ7
 27Ht7L4EzfF9/oS7y6q1C5O0OWh8O0+JSEarQMInnt6yBTRNAyBdxvW40nn5H94dSCId/
 nPjPxF8H2tRximW+/F1xDzLsqeX0nnzhOlcXKjoJJgSvG8GwdtVkerbUDgZNWa3oGF1+d
 XbjaI6DA/4BWSiJCeS+HcoF2Q7FPzH+bf5UgWtE+sg2FZvvxi4we4DfvtjTeVLlawBw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=protonmail.com;
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=V2KmAE6P; 
 arc=none smtp.remote-ip=109.224.244.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.116;
 helo=mail-244116.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=V2KmAE6P
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch
 [109.224.244.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EED4C4075F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792007978; x=1792267178;
 bh=ln2rZU0gjriKrZL/BQ5o3inHHBXjf8vwIS9ZY5vKPzY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=V2KmAE6P0qb93UxLf0pve2kQWxG0sSu5O2iSwI1GqhH2G+wBi7fFiW9TZ7ceIBMq+
 9OXcFrce4fRzLc+b5nvhfkoPaKSWPzDg5zgFUU14wOA/FPqIkS5dfnRAmJxdn5TIDB
 TvIK6acPwGpgSA9cMgux5lihVwtlsb33RefUuFGphvsLA0J+WhfkudV2SyFyZYRqB6
 KtC56saermCUq0f9OBRXLEp/6tQrZ9CByerLFDBdvh1p9UK6+JtDRvMCYxQ86F3cHa
 akJLHxxJgLOnhlr5ufa23+PzJQ1j4cFtozX1dd2jY+nnAC8Kv7MM4a8/twe6rYdwTQ
 wn6R8V5pqXWaA==
Date: Wed, 14 Oct 2026 19:59:33 +0000
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Zixian Zeng <sycamoremoon376@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Anand Moon <linux.amoon@gmail.com>, Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
Message-ID: <20261014T154006-0400.uboot-k1-mmc-v2-handoff.DaveWK225@protonmail.com>
In-Reply-To: <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 8224bec0881d69032a55939270d8df95f0510ebd
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On 12-10-2026 19:30, Kathpalia, Tanmay wrote:
> Dave, I hope you are aligned with the changes discussed and tested.
> Could you please post a new version incorporating them?

Hi Tanmay,

Sorry for the slow reply. I'm moving my K1 boards to a different boot
chain, oreboot plus EDK2, so I won't be respinning this series. Thanks
to you, Zixian, Yixun and Anand for the testing and the careful review.

Where things stand, for whoever picks it up:

- 1/3: Yixun suggested a sane default max-frequency when the DT has
  none, rather than trusting what an earlier stage left behind, and
  asked for a clearer explanation than "happens to return 0".
  Hung-Chun's RFC, "[RFC PATCH 0/2] mmc: k1: do not require
  max-frequency in the device tree", covers the same ground.

- 2/3: the BPI-F3 failure Zixian reported comes from set_vdd_mmc()
  putting the SD I/O rail at 1.8 V in SPL. With the rail at 3.3 V,
  Zixian and Yixun both see multi-block reads working in SPL. The
  agreed fix is to drop set_vdd_mmc() and enable
  CONFIG_SPL_MMC_IO_VOLTAGE and CONFIG_SPL_PINCTRL, so the driver
  sets the rail and pads itself. Anand's dtsi change adding
  vmmc-supply/vqmmc-supply for SPL would go with it. Both need to
  land before or with this patch.

- 3/3: Yixun pointed out that clk-uclass counts enables, so the clock
  half doesn't hold. Only the reset half, where release() asserts the
  shared reset, may still be needed, and that needs a test or a
  reset-only version.

Tanmay, Zixian, Hung-Chun: if any of you wants to take this over,
please do. Keep or drop my authorship and Signed-off-by, whichever
fits what you end up posting.

Thanks,
Dave

