Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069FBCA5FE4
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 00:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 274A04080F;
	Sun,  4 Oct 2026 00:41:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id URutBIkoW1XR; Sun,  4 Oct 2026 00:41:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D6A0407E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791074510;
	b=oDEjmM6Uv3si82Sx4LO41jDZyIgi4N7XA5K2VkQ72bj2AACvCGN/2d8WpaG4kqsQEH8/
	 qF+G2NrPjrDupRfxH6wrJKHjm32CuKmXKZV7BFP0wK96tp93m+4efVjFow9Pey5Hfn/fr
	 78hyvDEQZIzmrGP1cOZavY4RcB4b6hDYhZTvhx5K+pAW634p6Oon73jhQ1mjtNQgjnt8D
	 i1Bt6bPaEJvjdGzFxWbfQeuCqKD/kJF9CQbJrOclbxYCjul6lEFue3JMmU2dGPNLR+/re
	 Zka4kGbhgVuLiPKvIZHSnZ6qZxUCF29WJ3L+Mt3Uptu7L+akVCQUrrgEzjZFNMYD9LQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791074510;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Info-Out:X-JNJ:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OMuJ9xLzI5N4NSH4o6Xa12e4rmxXH/z7NrT6O4wZXx0=;
	b=p9jmxEn75i8tqUi4QtO8fJO+zgJYdIQakbB1+WqNh72TnBPwsFrBbVfcDK+PeFsOknpI
	 XPlxSiLqdEcBWNlUwICbAeini/e/7zB2HK3fezOUxpembodOMLzpJ4EcwgC2O/E2+qSiH
	 LmPSo9WYgFKFWu9y9O3oTg5bJzCz3mAaKavwrfkKQmIP65ypnLtPDOvrXgkR8SW43yOOj
	 esdMHVSbbnCTmvxjcvbAi2XEV6dQE2M2x0lexCfkH77L7iDKwUGqRQbD6HXEfj2FYZTZY
	 sp9dNg7i/Q4vyVouDTzAJglIbcR4KkAu1jCrJHpYQA7s33cvZX7ZUpjp93thmkBRPiw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791074510;
	bh=OMuJ9xLzI5N4NSH4o6Xa12e4rmxXH/z7NrT6O4wZXx0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JqoepZ5Jfc6TnNjnVHgPcISUrmNmqslb09BPsemdjYLRCT6g3ljUy2oQhGnG3Ipcl
	 628L34bUMsjeJWY+K+awFFgGcTzvade3hmUqZnOs3AywPYWsl4+jLQnqeaOyZZX+nd
	 Q5MmoQzM9wxf0FOSxtDrmS6ndkqKhRGgXXpSiKBqaWuZq+wumktwfAjo/U5Y1GMLtV
	 MBLDT0xSJMfIc7J9iJ1nkgI57qhfWmIP8yHJRJl56NoaAWVSCHOFfx2q65WkKCcOmx
	 DomwUl/5Y3vUfQXkLU5uJXG53th9p+RN87J5OMpqstPNvYUyEN+p6sUx37jE1yxAD3
	 8S0Nkgr9GrkuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D6A0407E3;
	Sun,  4 Oct 2026 00:41:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6934B335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 22:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F3D66062B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 22:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id srvM9Bds_cwP for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 22:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7244960624
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:b747:3001:205::71"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791067578;
 b=Zc0jPUv8qZ2dYTlYdyQ7XUJmf18LlhmQlJeZdMWklcEz8WBjmedorsWZQkkb0kHRjFFk
 VPsFQLoWJq2l8a0osw4kimuhRxlQfJHRcTSAtFezZPL1FlTC/eZIVGEPWanEkE/0q12s8
 29/EkOt3bRGgxjJlGNuR/1B7AgWsERI71MnU4scNFXzoloMiN/5G/BqpqM8oZsCkCyhyn
 cm5w6yn7y7C17d8uJtbVe0mY8NKWLyDrrkq3H45q8eNqYjKgNdzuLpLcng2B9SDa7niF+
 S9jajzcGiC2oszmtmfIc5C0URgFmrKfyPHvpdq28hkLCmxS0t1njQxAm1k6egKM1JpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791067578;
 h=X-Greylist:Received-SPF:Received:X-ICL-RepId:X-ICL-Out-Info:
 Dkim-Signature:mail-alias-created-date:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Info-Out:X-JNJ;
 bh=OMuJ9xLzI5N4NSH4o6Xa12e4rmxXH/z7NrT6O4wZXx0=;
 b=RvZj3SNsAGOpIeCkoGv4FLhuTjLV74mC46XXDy6pAgOiXlB1QJton1vlkvoLcAZyBwXo
 vgCQrUBfuqipUUyWpEmHG1Sl75RU5glfx/c8muVdc0huSt8Xx+CiHTJQsmeCiQUiEeFbU
 KR/hPXaw7nILbySNLlNi723ohNjzJfCs2WegtPw2oWq01W1sDe+BwBoH6sHTJnzcoHtxi
 avAsxkmwuge2i6DKfixNVbF+DTafDacyUmDRyzJhkvtqjZMR+V4YK4KSjQruPS/QVHL80
 JToQ/muhiDljRNnYVFL1UcVJ0W9SIzmVyDOhPgs8YZdrlu6GcjJb6EayMNjYun3BD2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=dxdmail.cc; 
 dkim=pass header.d=dxdmail.cc header.i=@dxdmail.cc header.a=rsa-sha256
 header.s=sig1 header.b=NtDRZsB0; 
 arc=none smtp.remote-ip="2a01:b747:3001:205::71"
X-Greylist: delayed 600 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 03 Oct 2026 22:46:18 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=dxdmail.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dxdmail.cc header.i=@dxdmail.cc header.a=rsa-sha256
 header.s=sig1 header.b=NtDRZsB0
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3001:205::71; helo=outbound.st.icloud.com;
 envelope-from=nacht@dxdmail.cc; receiver=<UNKNOWN> 
Received: from outbound.st.icloud.com (st-2002k-snip6-3.eps.apple.com
 [IPv6:2a01:b747:3001:205::71])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7244960624
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 22:46:17 +0000 (UTC)
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-1 (Postfix) with ESMTPS id
 3281F18000B3; Sat, 03 Oct 2026 22:26:36 +0000 (UTC)
X-ICL-RepId: 01a103e0-597e-7539-94d4-465a32406ed9
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFBHV8DXhxCC1YCWw9LVxQEFlIOXx9yFEEcXgxeBxwTWlhVCQoPShRUGVoBGQhRUEsbDlUXA1ccVkVcGEMJXQVXHB0eQ0VbE1UXRgkZCF0dGQhHHwowA0IOVgNDB0UALRkcV1BTE1YdWBFfQ1QIEh1QHA5RBVsARghIA14FWQBGCEsdWAdaBEALVQJAWQpRGE04VxVTBlMZVVZQDglLRglJHQ4OQhhGH1QnVwJaClse
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxdmail.cc; s=sig1;
 t=1791066399; x=1793658399; bh=OMuJ9xLzI5N4NSH4o6Xa12e4rmxXH/z7NrT6O4wZXx0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NtDRZsB0lfhMzyO64vLeyLD/N//WPAMvdJk8LEgpRbHW8TvsNj9jYXz2bq6JPwa7b9GcB6FMJRVW1PsDgi0E7do/Na6QWL/6KfaZlnPpgha30Cw1HHs3EdkaQtick+2x4aPF0gKC0aAnUptiTa6cSNBzBiFAfnn8fWd3PESF5B2ECbDNWUphsVYI0steGzIUkdu5VquvV71qaswIHTf8dOKfyFCIgsqqntyTLnHtJqqlrxSc623Mhxlkid0GPIgtphU3KQrrASqpuV1RD54QWVJfNQ0h7XSVAufxdiagctoSPSvj8nfBlUDT+4Pnb5HrhHGUfoVeEs6+QEU/Bd8Rig==
mail-alias-created-date: 1790174225171
Received: from fedora.tail053708.ts.net (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-1 (Postfix) with ESMTPSA id
 1425B1800164; Sat, 03 Oct 2026 22:26:34 +0000 (UTC)
From: nacht20-de <nacht@dxdmail.cc>
To: u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Aelin Reidel <aelin@mainlining.org>,
 Sumit Garg <sumit.garg@kernel.org>, nacht20-de <nacht@dxdmail.cc>
Subject: [PATCH RESEND] video: simplefb: only use stride after a successful
 read
Date: Sun,  4 Oct 2026 00:26:13 +0200
Message-ID: <20261003222613.501602-1-nacht@dxdmail.cc>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA4OSBTYWx0ZWRfX/VXKMgz+iM1y
 pPdTqO6gDiCsNeJUm0R8q5DtPgHbqsH557oae1PjnLqLnYD3d2z70n3VGcEsvsdr6XSyuGbL3GH
 scbDhiycJoUpDVcpx9ITEjj8Yz0+Izm8OA8tJUfN15Tqur6peOUs8xT+ieGBMe4A+eXgKaDek7C
 35v8oOQ/Ns00Ex3edfQA4IRSIClkRtiftS68kKnfbA7EPxFjtG57Zkzkua1FPbNy0dTNNlmb3yW
 7DCa7gP5is9jRob6/Hw+Y4LchEl/Oo5wdDiK7iD3stGL58ezZpdIoiqjM3MG48+cx2q1zRPRQvi
 5UtvtG9GkfuFzQnyiH0HU7EwonK1CkIEbSRPTiHGyZeW2qcHogVeapySwidoRo=
X-Proofpoint-GUID: 7ZSLfb8imq4DrtE6eOPguL_freWAQhzr
X-Proofpoint-ORIG-GUID: 7ZSLfb8imq4DrtE6eOPguL_freWAQhzr
X-Authority-Info-Out: v=2.4 cv=H/7WAuYi c=1 sm=1 tr=0 ts=6ac1811e
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=PcPjnYndKbKTwStW0L4A:9
X-JNJ: AAAAAAAB8GNn2z/0qgug6TQ9DAfYck5TgkRUePh5WGAksJ34beeHHY2g6998YcQjIrkIcA8uU1rLRakEcMauc81U83nCnPP3hC4G9Ts6UMpWqE0OgXxSad912VwpVCxfpRVBzuqL+zaSR3zdAZTRGIkKdg1GJhtsGqGPSULGGkmTr2QwiYkzUPloPdyE88ZmFnxj+Mc8vpMLbBRZldFwrJjqm3UylKPiVFYjLNL6tVVOuG/XzKuvP10ly7d/wAYI4uRoSxs6DgYWAtYtH46oLRuSXJU/zsZ5tcG70n/JPvcAiwFJ0deY/t1mCoRlsHUp4pX8Uu5E6FaUiPUOebKjNikkcdUXmEEhm01K4+wfloWdAgALWXvwO/moXuDcvZkEGTb0FiclFA4QGTGQ3OMsUgK5uuXxm2MJOrfOCz8a5PK+TQxgY5rpYeOn+MYcyHXUSEhAatWovpm/Yjbb7w/al/OkA40aSvPCojkDdl5jgLP+sB36MseFzv0tWHb1E0dTRARizNf9NliMIbIscu+sZdIEy1AAwdNmeiF+hhW8fwj0ahOK5IDt3C0nZYXvoLzWDED463Yv8KLzShVPlr4ItI3Zwh1xxerIWTB6+GzPYcMMvyYjMvtBty0hcW/iPP3QnS53GqIGzrFdjAdeX9aDPfuslh2YdzTXVkPsig0Hzo1/EYQdEWEuh0PFNJkXEprAFmbxuOpxcBP33Mc/6E3zVD2F1ZxUulkmljgey4E7qpFD55gJJwVK0nIYY8XzGaNoH05h3BVGWHzFzq0PaTj+A0C8bAWzeWNDUFMGInD5G+JhJXns2qW8rDlUl3+F7cEfAcbFjqOGEPXF8q4Zal5DIVYUJv3EMh9vyjysDCMiUI6uNYOxsrciHYLfZHyE2zFYtzfKHyA/rxcM0wACVVhycrnIvenWltlcO8Bw7rPavFke01z2j9hTfeoyO4Pa/yDIs2R8tXv2vDienjUfpgKNWxVLquL+YaP
 o+3xY4yiL+L4F/0RxB4RIrCxKAVKBqdVBxtxv3T4qzIrAWxLWZS0KcU4VMttoOT7jHvFAb3tBLqDbWKnlkxEtYkflJmNBOKrUsWYwpMygr3bSahHGCPD1C1sQ1DJdzNMPNl3kmgSWb8URQ6Wb6Pa7dT7WAPa1lG3PU7/BrCZEu8Q4v93CfvR7QqXPVQ50NOCCX4xnKnf210AM5PUMuXWMrrMML14SUFgLzGsaFUznNnNq/R2EvGt2ZCYBc/TXHASnjESqGG9dx9APi49Cmwy8do1pwXOyvedu5d33QFNyz6XFkMV14aMixSI5KSU9tCWkNIZkxf9W6D9k/KeD24XOSRc=
X-Mailman-Approved-At: Sun, 04 Oct 2026 00:41:48 +0000
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

The "stride" property is optional: without it, the video uclass works
out the line length from the width and the pixel format. But the check

	ret = ofnode_read_u32(node, "stride", &stride);
	if (!ret || stride)

reads the local stride even when ofnode_read_u32() failed. The property
is then absent and stride was never set, so any non-zero value left on
the stack is used as the line length. Clearing the framebuffer and all
drawing then use that line length, which can reach memory outside the
framebuffer.

Only use the stride when it was read successfully and is not zero, so
that a missing or zero stride falls back to the calculated line length.

Fixes: ac56c61332e6 ("video: simplefb: Add stride handling")
Signed-off-by: nacht20-de <nacht@dxdmail.cc>
---
Resend: the original posting (2026-09-27) was held in list moderation
and never reached the archive. No changes.

 drivers/video/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 631ae00b1e1..6d7fc23105b 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -69,7 +69,7 @@ static int simple_video_probe(struct udevice *dev)
 
 	/* Optional - in most cases, auto-calculation works */
 	ret = ofnode_read_u32(node, "stride", &stride);
-	if (!ret || stride)
+	if (!ret && stride)
 		uc_priv->line_length = stride;
 
 	format = ofnode_read_string(node, "format");
-- 
2.55.0

