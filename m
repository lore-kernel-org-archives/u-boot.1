Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C505606A31E
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ACBLYSYs;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CuWlJgs7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57727407C9;
	Tue, 27 Oct 2026 16:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DkamuIOhlgqj; Tue, 27 Oct 2026 16:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AAE20407D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116919;
	b=LUteJeSjxwHj7qm8wc7UKXj5awzzK22WfnjRXB3gxrDa3nC05ljrsmYODMW06lgsIcis
	 HrPZtYHnyFubwNvgmjhSSf+ezlX1hpXXZnzezM1RSlgCdJi4DUHvnfD5lRBHLaxvTYs0V
	 8k/p4YISzEelno3gNBl9x+SsQerc1IIEpqATUz3IpNDaE/FLwlaSebSFdR8WaGAW8+vRn
	 XRIJ5IrNqbOmvr0TYyDoHkXq4GRSOV9s30+wSSraIijg7XvsU86JLKaS5eu5oS3F/deNe
	 QLVuCVed8CW4EhdNJVfpQIrU1iSifejvGvZs9Ue0lyHw1I2k+V5aEVzVQtRSwMcf8Ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u42YZOmdCd+JOl65h2X1ol9cxYtSvdUF2XPfW/8CsaI=;
	b=YnIsYwCR85fdAIpdewDPZL74goEwMnGTtUnLBXUTsQdAzjwwz207EYqYTv0LGDr1qVRJ
	 JnPKd3VsrJyFjLh/TTafxSc9NCJzqfAqLEEoKaMo8VIP3vfOG9lZo4a/UD1yDrCT34B6s
	 GhQiVVs8++KbP0uzuKhzFRfS+sU0spbPcNB30fiJXEILdDr74Sf5htZiiQWIEq9QKTExV
	 8gp1FzXAaw7DFG7NAaLb37XnKU92+fpr/zGUAhcLmLzY6B4/O7BTP6kWVup3a/npPoRgK
	 I+9aDmElu711zJiJqFp0YB8fqAmnR0cT+O9uSax2Xs8O9S56NJHOTDqyAHahnXkhkMQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116919;
	bh=u42YZOmdCd+JOl65h2X1ol9cxYtSvdUF2XPfW/8CsaI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ACBLYSYsBiZ9yHqRKCtrqcSfbY/OxidMnbEcBtZjjmCqfrjnXzaX4JcX039pPkhB+
	 g+ix0y8A+RWzxzWg5TJjE2R9I6ecSxW2tpMI2HzYXg6LbfkiAz44hfMaMd6rh1LwZ4
	 uNC/nTjygiKHkij7m3+0vtg4kHbUSOSv9t1LHKiDaNPfoQubyb1rMozdy0K/fFnYY3
	 rxzsOs9ADBUB1Wzwcl5T7a1zxgLJkyKudkC26CYMRCLSywHE4dxq33+IxNnnDkL10D
	 2pazhOoeB9ooTmbe6jfT3dSrC2JyqakUYDyD3yItZmxJ5WuCVwb4AfLGjQMFL55wpk
	 nzfjxhEerKodw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAE20407D9;
	Tue, 27 Oct 2026 16:01:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2203C235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 086EF402AF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:38:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrHEYz3t5giz for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:38:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 263BF402AA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793111934;
 b=FYAAQW69t5KoT1T5WitczSM5ZhUFe5uCwflEoRqpbLwrLurko9TFki3amz6kqlLAxFmd
 3/+PBvSNe6spcSAqbC7IK150qP6lOkm6XS+S4aUUqmdFrKH0nnTGYaCbhInZSAMQS42YF
 YGWfjJJ3YscUpTT8grdEM/wrIuunAaXK88Uwrt6FygcmI68E0vMOONpKhNj+d/P5ge/iu
 X5DX7ubkXmjnBpnRhzaqPpzN1wrLBYrV689c2j9qmpzEIYmx+NbpB9fp5Oh1crb3AAOW0
 1PvxMSLoswQ6Wvg2Fogc5ge4dNU7CVtrcKOm5JVA2bq+ysJb9jNVe6gtyqtcxHamdaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793111934;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=u42YZOmdCd+JOl65h2X1ol9cxYtSvdUF2XPfW/8CsaI=;
 b=Wba3kSnhJg7v3aLME1rWdvoeSoOcd6BEANtUerqtW3fiJcq+KrMc80mG/HPNcaQw6zIh
 JMXUOTtxkP9wI/A2ABwgShnNrsHPV6SabhFm30rb7yHqx2gKQooAMJVI9mcMB2V01NMRo
 csZRt6wg8X6Ba8PD8iyQRiFGpbkZLsIyQnLZgBc2ftraNK60djvyw1rRYnESFd4r+HR0D
 7l99mw26M9+UZR9kY2DrtnCPp6JqDAA4Wc5iJ8FclQteXAeFcYrglIR3rPupNZ4yzAra1
 goYkl/W0/+7TgoGG0hNropA3O+jC9ekUPyV/DYCaZf2M21lQVy0fcrVHPsE9WrLN0XQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=CuWlJgs7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CuWlJgs7
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 263BF402AA
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:38:53 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-53644ab1f7bso35513711cf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111932; x=1793716732;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u42YZOmdCd+JOl65h2X1ol9cxYtSvdUF2XPfW/8CsaI=;
 b=CuWlJgs7mSkTi7N7LOpmRP/OnBCwRzjhlfkYVL1Zpbek/ahED2cwEy89lwpN7Q4ITu
 fZ6CQIt7EULLuHS2Cp7BTM3Mqyc9aSc1moZs8ZkmbzbB2S2eeUAKgT9FrABaVdT8Ppl/
 34ysKLIgtk4hqBZQoGcg275uF9VFz1t5YszJNLG6G6z2gJQfwJ/JhTi+u2x88TZzyU+9
 vfsCc4IfbXy3d/EaTDstG0HPLqYNdsoUCBgYduaihDuiyhILTP4O5ya96ZhV55KZ6Pyy
 HJjdFwheEC7oGJXcGpCVpQr0oUxucHy/YET/TMggGJnvjeL3s7AZr4yiGTlJoe0MM1WQ
 0PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111932; x=1793716732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u42YZOmdCd+JOl65h2X1ol9cxYtSvdUF2XPfW/8CsaI=;
 b=o1FmXzNSRSYTLPxzCNZRrhBPywcjd+wv0LDX+P0VsSoY/rAdyLCePXCDC3mcGpnQFk
 RygRw5rSZvCiub+4KF9JfFghU0wYFe5RJNmRZCGAVBRtOcHTfnsWjocrMt4pPFrTRmjG
 sZnI6+xobXurdORBA1315Ng5nEYQz9t4314UkPGewi98nsa1hw08MWN64O0/jaOa8eRI
 D0ppIRbrIpGoM7ovuPVO8PC9cH0aShXiRNBTfy+hDNuuscLp5q3F69QD25Jkuic56/z4
 V5c3oM+a3g9l92qwV+Pbgz9adWpwg0bRUDoNCaAXafTmbgnXWBnlwAG8GpPWOgG7pfMH
 6oaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwM3djQBPWbJazGp50f9XP1ss97zWqH531q5BPThM+y3MT1xBBjTxiobJ0LmPzZG1ir2bFlr9I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ79rJFbqMOrdVyeI1lZIPHdvEkZ0kXF3YnSFf3zV07UV72jT0z
 2CzQQ41yzyx0j0q86jCYt9xPn2ghrDSlDrDS/tcPnWK99ZLRD40IvnIt
X-Gm-Gg: AYBFou05SIVgaaPvZog/fKwOWizBQbjiQdYNrq2biSNsZU701fnGZuNqXhGIf28UBgI
 z2sI+MQp24hxMHaMLJZrMwE4caKiEvqwDWROg2YEP5V9q6TVcyfEbB/NqvZgF9SAlU6FzkTYwtN
 NdCk2rCgMIKOBllpwkJSZM9skjUIdbPd5/ndOEX2hRBSgU6Y2Dt1ij/8ZvJE84vFKoiFRJHsvJk
 nbBMe3ogOhg0ZH2vtS+UutnIWuUrOihnSZwv7K+cqx/RSU/EIxUfeZrTL4w3bNgX53YKU28lM00
 Vtqleelp9dWuZpiXW9Sjy+8ehXJOolK9xkreG0b279tSgOIkZRfcUNbAZ6Zt8+UnVRUydqVVuq9
 lBK2Eu1b2pabsYEomBFAIkLHewPURKCF/Pa2tcup4GLyjjp0b5PztL0i7h7VSDYv9whAHCSXMql
 TWkUOMWwYNtp6DBiuO0njYdAQLcUh7HSfC43e4QwQG9qtWWJKAa1vMDxaY1BEPczMqGd4zaBfSm
 xEbwvYVLFWUxUPKxd6ZfL8iZvIaM6Hxd8ooxbzhHf8lXmHzLbZwmxcGkJgkbvayRJt1JcYv0i7T
 pO5RTje7DoMjwIx+oN4zqbEe
X-Received: by 2002:a05:622a:308:b0:533:3572:250f with SMTP id
 d75a77b69052e-5383b52d4aemr164588751cf.36.1793111932051; 
 Tue, 27 Oct 2026 07:38:52 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47cc88d1sm102374116d6.38.2026.10.27.07.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:51 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] clk: Do not disable clocks when clk_get_bulk() fails
Date: Tue, 27 Oct 2026 10:38:42 -0400
Message-ID: <20261027143845.1246876-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 16:01:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

clk_get_bulk() looks up the clocks of a device one by one. If the
lookup of one clock fails, it calls clk_release_all() on the clocks
already looked up before returning the error. clk_release_all() calls
clk_disable() on each of them, although clk_get_bulk() never enabled
them.

With CLK_CCF, clocks registered by id are reference counted. The extra
clk_disable() is ignored while nobody has the clock enabled, but if
another device has enabled it, it drops that device's reference and,
if that was the last one, turns the clock off. Without CLK_CCF, and
for CCF clocks that are not registered by id, clk_disable() calls the
provider's disable op directly. A device whose clocks property names a
clock that cannot be looked up, e.g. because its provider is not
enabled, can therefore turn off clocks listed before it that firmware
or another device relies on.

There is no release operation for a clock that has only been looked
up: clk_free() had become a no-op and was removed in
commit c9309f40a683 ("treewide: Remove clk_free"). Therefore, 
clk_release_all() does not undo the lookup, it only disables the clocks.
Return the error directly, and reset bulk->count so that the bulk is
left empty and a later clk_disable_bulk() or clk_release_bulk() on it
does nothing.

Fixes: a855be87da49 ("clk: Add get/enable/disable/release for a bulk of clocks")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/clk/clk-uclass.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 3fc772c8b4f..3d0b1c4dfff 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -159,7 +159,7 @@ int clk_get_by_index_nodev(ofnode node, int index, struct clk *clk)
 
 int clk_get_bulk(struct udevice *dev, struct clk_bulk *bulk)
 {
-	int i, ret, err, count;
+	int i, ret, count;
 
 	bulk->count = 0;
 
@@ -173,21 +173,15 @@ int clk_get_bulk(struct udevice *dev, struct clk_bulk *bulk)
 
 	for (i = 0; i < count; i++) {
 		ret = clk_get_by_index(dev, i, &bulk->clks[i]);
-		if (ret < 0)
-			goto bulk_get_err;
+		if (ret < 0) {
+			bulk->count = 0;
+			return ret;
+		}
 
 		++bulk->count;
 	}
 
 	return 0;
-
-bulk_get_err:
-	err = clk_release_all(bulk->clks, bulk->count);
-	if (err)
-		debug("%s: could not release all clocks for %s\n",
-		      __func__, dev_read_name(dev));
-
-	return ret;
 }
 
 static struct clk *clk_set_default_get_by_id(struct clk *clk)
-- 
2.43.0

