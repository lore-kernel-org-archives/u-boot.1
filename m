Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC82CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA31C6071E;
	Tue, 29 Sep 2026 00:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LO7td3gsCxpJ; Tue, 29 Sep 2026 00:22:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B4B1C60725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641342;
	b=r423t4l80nnHdE7Oc2cgLmzFQNkCwZ0SfAhZ1ctIB75+NJacr7d0zgH96NXOwpHekIhi
	 Xf0SK5C9cmFiNRL0qCgthtoiMLNaEIFfzLZr8SFMLg8PYyl8cZc9SxPNiGJeV04io8hfc
	 SgJ3Ve8TwHojpe0xa2OBDf8C4x+8C5t7ue/uw8/R7YIHCjl2m/qlBRqf/tCuwsjN9xqLI
	 u1Jjzh6EpreJKe2QOJCuQcGJCFYi86660Z0M+8KRQ4Nn20FHxM1uu8sMHFkOmLTsz15Ar
	 lr/+A4HFCOF9Xid/Z+fFA49cnJj20tvbF5WCk2U7Tzmy4j/JsmsIzTqxbCThWB98oIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eI/GqNqGcntVVe6MZw4iTqECcvQOsLQu/YXTscsCqLo=;
	b=eAsWeswQv1xF6LQnD7fSmKh9XgpKdb866kT70TIC0Ck25LW/G7HOiw9StrU++cvJR1+U
	 USHVu0TDMJd0eNukIU9miaYzd8YbxerwiQOJmAy0UY7BbrU0OL1BYQWbGMU4eL8/SeXHF
	 aZnGVC2L+j4tzw9fhYHANqUqdluPPp2+R5JewVI4AmIGOCM182xcDo9tEX2FCpznk6Rc8
	 bn3qznayxOGjFw8q9dvvWxPFCos03BiihnBAHHnxqdk0jlc0lrDrVVEI4PQUSqaeox9u1
	 Lgg/ZPMwIiG8k8Ckmz2cxtGohrz/kQKAPEhqqxmFXOt96Sz7zkXXOup3b/ttupfXjZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641342;
	bh=eI/GqNqGcntVVe6MZw4iTqECcvQOsLQu/YXTscsCqLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aX6yOZhP3yjvBZ8A1WqckxT86y+1tilslRJfW2pVpk+xM8Cx7/TeW9+995NmTrQCA
	 2mVqM7/f+YnqHaaNpNtekPuVYSsmojQKCKkMndOgC1T/WPjvlmLnX5hQLKtps1wLo8
	 ZHXEYNqPldsUlFDU5F0qs9Jo5O+GCFT52NEx+NFdHx+SlHr4HX1+oRBT/NhGBgEtEu
	 uylumkkq8GH+s/YEtzArheOjs7D/tzgewwD8rhCsUDkg0TMgGQJB7RJFtf0CQZd0bT
	 VAnQz6vhBnO9JDiDODsOXLlb+E7coHJn4kTXi4NLdBZS5H4kfyVJmTWc2cjILSE9cb
	 HKW2AB3qkVDYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4B1C60725;
	Tue, 29 Sep 2026 00:22:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 893004CD
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A5F240247
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfIkS3a7ZJ-h for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 61D2C4024D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641334;
 b=G8TC9Cjjd1EcjpRGt+wZhAlFJwJatzl+GAexgQ6PiKLid5uGDLmHby/O62P1HeLaRNXZ
 t4tZA9DXAxbfeQ9HTKX3r25u0SKh5NqKHKFKlc08N5sCEZyBtbWDM1GcEPTqUI+YwizHU
 wJSZB9925ME9oNI4Pqskjv0FHZqeSAVVhDrjinoQsVkqHiMghQ6gqIQrCEo5IMlMGru0+
 lRY2bY+SSogGbrrzcIvx7wf6CHKaphHJ+8gdHTGKdzqX6dyUmNgE8gq7eXaHjH21N06j+
 54YjjTQliwuGYINhrNYqVW/h+K9d5Hk/xBXtbEtQGx8Evq6pduJJLpScEBzDnC2VVPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641334;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=eI/GqNqGcntVVe6MZw4iTqECcvQOsLQu/YXTscsCqLo=;
 b=qdaMV2dXFk5m56unWbVqDihce8txe9QLLZxxKkzdz/b86Gry94dsMLdf+Om+FrppSKbt
 eUjhxx1YtkTgLDgiq7bVqeV0y+ylDyh17/z9750AFJUWLh8ocYI7dQGrezriWsUBvQjSw
 wFzPe1+cZOGjyXXoaAXFTol9hEWMFt0ukgVIhBVeBdwVrLuzNWf6vyHuhosUKjHTRqlrw
 DGQTqqnLYWBepzxGf5anOx8amvYNEgEpL6uVdxAdetQZ3rIhdZuNzpx+zOT8tkuC5uMtN
 IQxL56/CJFRYFYepPXPiU4L/eSkqZ/8ymtIJ4Z19NeqGz7GH8yr9/m8VxqW0gkBQubw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VCj38zMU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VCj38zMU
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61D2C4024D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:13 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-81ad35a4608so278924a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641333; x=1791246133;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eI/GqNqGcntVVe6MZw4iTqECcvQOsLQu/YXTscsCqLo=;
 b=VCj38zMU0tHJbk0PIF2+TvHFd0ng/1xh6G8OJQiSND+OW5h7IIJVzzl0PdOZdnV+O8
 jTqdWsZ5Ux+OMuixBaWhrofuCNqPNqaM7f1C1mJLvpKVzOE0nnvbEgSTfV4BScEcFs3K
 VHlu8AJLjiviPKumwtSMzo0b+kPy0hC/mJuM4RDuduGqPL/JXp7SMB0xJs3VSYiNDVaS
 Vj1vVQyv54kit4lWa44kxdRLQpiInkXxGWuEXafuO0VGoJsArzlL7Y9CANiJ3Q0SSwmN
 kvMHYlorxdDu8KQHrFmpv8Oz5r3F1VvQCEeZAbwdqvv+5q4cz5/vshfU06jxCyJ8HnEx
 PBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641333; x=1791246133;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eI/GqNqGcntVVe6MZw4iTqECcvQOsLQu/YXTscsCqLo=;
 b=Ypu8z14jeBR4KKxRSw253Pva66osvfDSbey4yDNStaWLhWwnNjs7IWmpYdbGEbUu7l
 92M2CCTP1jfu9KvGPtSW3xIGfnfMz2z9UBVhn6FDjxcIs88uYavL69l1zSwNNU9v1hjT
 1SBc5OC0zUEhwhavAuIhl988t0+G3eB20wOioSqqxOYduXaQ5aphX6kho7k2PBHgvB5h
 ECcW5LqKDImuAath6QlhVlnpggDBLRWNkmwIIQ71OJwYGgbLo0gqQnv0WEyicr4+4UxI
 5VOO1oySQiwccrJyMeXqddWJ+QWgblm0LTOgl8NX+qSFx0AxNO7JC5XYSan3we6XO0wu
 R28w==
X-Gm-Message-State: AFuF++mrAZqg4cFVInKSrq/KyzCO0fpBjp1Y1BkBOtkLDfUwkXGxwDsz
 5B3ByeMEoRq66Wn2qjbRfD+Taia7ALk65rcPfQ6IT3TN1bgLzpa2EpUO
X-Gm-Gg: AYBFou2PewSoHVz/K4lDP52pJVvunUFCtDRbgkbfTcIeVxhZEcqtwYgI75iVeUy294T
 Rx2HlN2R5ZmNnpJUZzaAt+nPGsysLII89/7DZyq2Xt6cnVurUjOWxKlpEQgYpYEFCzOAL6ual63
 cLpFaDNjz+tyRhUjl1GklXzL7ovb2FyF6wRNdhDgVsTXXUvfJ1briwr3gsEOGcqHhkRJxEKHAWy
 psa4GtqHj8tlVE+KGHuDmGUeqoefs9fi9cOXIAm9BSPnftnS0U/oWDKItS6LJO/ZqSlMyCUwUFE
 7fThjsMCMmzu3iGXl11ueRw5DMqNiwnDcWThsaTw5IEf2k2YGot7ut8TdN/jXkx7kb056m5B8si
 mJI26z0vpMIiWYD3+OH4Dz+s5PwJKmaatUwVxnBGLRSJ8jAZTGXQPk4P9leflPf+q97DnfMTNMG
 k+P7tkMhFtedBpkSGrQhsiEPpBaRT7F15iFVJGU+ynLamA9m+ykHLCar9RlN2/Sk7DxgDDBQR0Q
 kmntE89S85Vp7dfe2DRlaPCinG+O9PUAU2jEzPNth6z4+ua42r6Fs9HcsaZVGhRDgVsJrV30Ib8
 cPF1BlEj2zOeJYNe+z2bGze7Nw2mV+JJS2d3C0x8rbwE5mGlYEDrKD6VYsBDfvLORP74+gsV5zK
 PSObJhoA0iOclooh5Lj8b
X-Received: by 2002:a05:6820:1905:b0:6d7:aca3:bba6 with SMTP id
 006d021491bc7-6db15a7dfbamr595394eaf.47.1790641332813; 
 Mon, 28 Sep 2026 17:22:12 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:49 -0600
Subject: [PATCH 12/20] net: lwip: honor DHCP timing controls and request
 header fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-12-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

Use the legacy acquisition deadline and configurable initial/maximum
retransmission intervals instead of a fixed ten-second timeout. Share
the customizable backoff between DISCOVER and selecting REQUEST, retain
the other lwIP lease timers, and bound values to the fine timer
representation.

Include elapsed acquisition time and the requested boot filename. Keep
the last DISCOVER secs value in selecting REQUEST as required by RFC
2131, and saturate elapsed time instead of wrapping. Cover the request
fields with wire tests.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/core/ipv4/dhcp.c | 12 ++++---
 lib/lwip/u-boot/lwip-dhcp.h        |  3 ++
 net/Kconfig                        |  8 ++---
 net/lwip/dhcp.c                    | 66 ++++++++++++++++++++++++++++++++++++--
 test/dm/lwip_dhcp_options.c        | 20 ++++++++++++
 5 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/lib/lwip/lwip/src/core/ipv4/dhcp.c b/lib/lwip/lwip/src/core/ipv4/dhcp.c
index 035df0f302f..387f8f8660f 100644
--- a/lib/lwip/lwip/src/core/ipv4/dhcp.c
+++ b/lib/lwip/lwip/src/core/ipv4/dhcp.c
@@ -132,7 +132,9 @@
 #define DHCP_SET_TIMEOUT_FROM_OFFERED_T2_REBIND(res, dhcp) SET_TIMEOUT_FROM_OFFERED(res, (dhcp)->offered_t2_rebind, 0, 0xffff)
 
 #define DHCP_NEXT_TIMEOUT_THRESHOLD ((60 + DHCP_COARSE_TIMER_SECS / 2) / DHCP_COARSE_TIMER_SECS)
+#ifndef DHCP_REQUEST_BACKOFF_SEQUENCE
 #define DHCP_REQUEST_BACKOFF_SEQUENCE(tries)   (u16_t)(( (tries) < 6 ? 1 << (tries) : 60) * 1000)
+#endif
 
 #endif /* DHCP_DEFINE_CUSTOM_TIMEOUTS */
 
@@ -454,7 +456,7 @@ dhcp_select(struct netif *netif)
 {
   struct dhcp *dhcp;
   err_t result;
-  u16_t msecs;
+  u32_t msecs;
   u8_t i;
   struct pbuf *p_out;
   u16_t options_out_len;
@@ -503,9 +505,9 @@ dhcp_select(struct netif *netif)
   if (dhcp->tries < 255) {
     dhcp->tries++;
   }
-  msecs = (u16_t)((dhcp->tries < 6 ? 1 << dhcp->tries : 60) * 1000);
+  msecs = DHCP_REQUEST_BACKOFF_SEQUENCE(dhcp->tries);
   dhcp->request_timeout = (u16_t)((msecs + DHCP_FINE_TIMER_MSECS - 1) / DHCP_FINE_TIMER_MSECS);
-  LWIP_DEBUGF(DHCP_DEBUG | LWIP_DBG_STATE, ("dhcp_select(): set request timeout %"U16_F" msecs\n", msecs));
+  LWIP_DEBUGF(DHCP_DEBUG | LWIP_DBG_STATE, ("dhcp_select(): set request timeout %"U32_F" msecs\n", msecs));
   return result;
 }
 
@@ -1027,7 +1029,7 @@ dhcp_discover(struct netif *netif)
 {
   struct dhcp *dhcp = netif_dhcp_data(netif);
   err_t result = ERR_OK;
-  u16_t msecs;
+  u32_t msecs;
   u8_t i;
   struct pbuf *p_out;
   u16_t options_out_len;
@@ -1076,7 +1078,7 @@ dhcp_discover(struct netif *netif)
   }
   msecs = DHCP_REQUEST_BACKOFF_SEQUENCE(dhcp->tries);
   dhcp->request_timeout = (u16_t)((msecs + DHCP_FINE_TIMER_MSECS - 1) / DHCP_FINE_TIMER_MSECS);
-  LWIP_DEBUGF(DHCP_DEBUG | LWIP_DBG_TRACE | LWIP_DBG_STATE, ("dhcp_discover(): set request timeout %"U16_F" msecs\n", msecs));
+  LWIP_DEBUGF(DHCP_DEBUG | LWIP_DBG_TRACE | LWIP_DBG_STATE, ("dhcp_discover(): set request timeout %"U32_F" msecs\n", msecs));
   return result;
 }
 
diff --git a/lib/lwip/u-boot/lwip-dhcp.h b/lib/lwip/u-boot/lwip-dhcp.h
index b3bbd9e5ba4..fd60dec2dcc 100644
--- a/lib/lwip/u-boot/lwip-dhcp.h
+++ b/lib/lwip/u-boot/lwip-dhcp.h
@@ -11,6 +11,9 @@ struct dhcp_msg;
 struct netif;
 struct pbuf;
 
+u32_t net_lwip_dhcp_timeout(u8_t tries);
+#define DHCP_REQUEST_BACKOFF_SEQUENCE net_lwip_dhcp_timeout
+
 err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p);
 void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 			  struct dhcp_msg *msg, u8_t type, u16_t *len);
diff --git a/net/Kconfig b/net/Kconfig
index b8b37c09442..93f80eabb18 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -46,10 +46,9 @@ config NETCONSOLE
 	  Support the 'nc' input/output device for networked console.
 	  See doc/usage/netconsole.rst for details.
 
-if NET_LEGACY
-
 config ARP_TIMEOUT
 	int "Milliseconds before trying ARP again"
+	depends on NET_LEGACY
 	default 5000
 
 config NET_RETRY_COUNT
@@ -58,15 +57,16 @@ config NET_RETRY_COUNT
 	help
 	  This variable defines the number of retries for network operations
 	  like ARP, RARP, TFTP, or BOOTP before giving up the operation.
+	  With lwIP this sets the default DHCP acquisition timeout to
+	  (3 + 5 * NET_RETRY_COUNT) seconds.
 
 config PROT_UDP
 	bool "Enable generic udp framework"
+	depends on NET_LEGACY
 	help
 	  Enable a generic udp framework that allows defining a custom
 	  handler for udp protocol.
 
-endif
-
 config BOOTP_SEND_HOSTNAME
 	bool "Send hostname to DHCP server"
 	depends on NET_LEGACY || CMD_BOOTP || CMD_DHCP
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index c68f97c5d89..94d4edf5c98 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -10,6 +10,7 @@
 #include <lwip-dhcp.h>
 #include <malloc.h>
 #include <net.h>
+#include <rand.h>
 #include <time.h>
 #include <asm/unaligned.h>
 #include <dm/device.h>
@@ -21,7 +22,8 @@
 #include <lwip/prot/dhcp.h>
 #include <u-boot/uuid.h>
 
-#define DHCP_TIMEOUT_MS 10000
+#define DHCP_TIMEOUT_MS ((3ULL + 5ULL * CONFIG_NET_RETRY_COUNT) * 1000)
+#define DHCP_RETRANSMIT_MAX_MS (U16_MAX * DHCP_FINE_TIMER_MSECS)
 
 struct dhcp_boot_data {
 	char hostname[256];
@@ -46,6 +48,11 @@ struct dhcp_efi_cache {
 
 struct dhcp_options {
 	struct netif *netif;
+	ulong start;
+	ulong timeout;
+	u32 retransmit_init;
+	u32 retransmit_max;
+	u16 discover_secs;
 	struct dhcp_boot_data reply;
 	struct dhcp_boot_data candidate;
 	char hostname[256];
@@ -88,6 +95,52 @@ static int dhcp_parse_number(const char *str, uint base, ulong limit, ulong *res
 	return 0;
 }
 
+/* The core rounds the result up to its fine timer interval. */
+u32_t net_lwip_dhcp_timeout(u8_t tries)
+{
+	struct dhcp_options *options = active_options;
+	u32 timeout;
+	unsigned int i;
+	s64 jitter;
+
+	if (!options)
+		return (tries < 6 ? 1U << tries : 60) * 1000;
+	timeout = options->retransmit_init;
+	for (i = 1; i < tries && timeout < options->retransmit_max; i++)
+		timeout = min(timeout * 2, options->retransmit_max);
+	if (tries <= 1)
+		return timeout;
+	/* Match the legacy client's approximately ten percent randomization. */
+	jitter = (s64)timeout * ((int)(rand() % 200) - 100) / 1000;
+
+	return clamp_t(s64, timeout + jitter, 1, options->retransmit_max);
+}
+
+static int dhcp_timing_options(struct dhcp_options *options)
+{
+	static const char * const names[] = {
+		"bootpretryperiod", "bootpretransmitperiodinit", "bootpretransmitperiodmax",
+	};
+	ulong values[] = { min_t(u64, DHCP_TIMEOUT_MS, ULONG_MAX), 250, 60000 };
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		const char *value = env_get(names[i]);
+
+		if ((value && dhcp_parse_number(value, 10,
+						i ? DHCP_RETRANSMIT_MAX_MS : ULONG_MAX,
+						&values[i])) || (i && !values[i])) {
+			log_err("Invalid DHCP timing setting: %s\n", names[i]);
+			return -EINVAL;
+		}
+	}
+	options->timeout = values[0];
+	options->retransmit_max = values[2];
+	options->retransmit_init = min(values[1], values[2]);
+
+	return 0;
+}
+
 struct dhcp_boot_option {
 	u8 code;
 	bool enabled;
@@ -283,6 +336,12 @@ void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 	if (!active_options || active_options->netif != netif ||
 	    (type != DHCP_DISCOVER && type != DHCP_REQUEST))
 		return;
+	if (type == DHCP_DISCOVER)
+		options->discover_secs = min_t(ulong, get_timer(options->start) / 1000,
+					       U16_MAX);
+	/* RFC 2131 requires selecting REQUESTs to reuse DISCOVER's secs. */
+	msg->secs = htons(options->discover_secs);
+	copy_filename((char *)msg->file, net_boot_file_name, sizeof(msg->file));
 	dhcp_append(options, msg, len, DHCP_OPTION_HOSTNAME,
 		    options->hostname, strlen(options->hostname));
 	dhcp_append(options, msg, len, DHCP_OPTION_US, options->vendor, strlen(options->vendor));
@@ -404,6 +463,7 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 	}
 
 	start = get_timer(0);
+	options->start = start;
 
 	if (dhcp_start(net->netif) || options->append_failed)
 		return CMD_RET_FAILURE;
@@ -420,7 +480,7 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 			break;
 		}
 		mdelay(1);
-	} while (get_timer(start) < DHCP_TIMEOUT_MS);
+	} while (get_timer(start) < options->timeout);
 
 	if (!bound)
 		return CMD_RET_FAILURE;
@@ -527,7 +587,7 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_FAILURE;
 	strlcpy(options->hostname, hostname ?: "", sizeof(options->hostname));
 	strlcpy(options->vendor, vendor, sizeof(options->vendor));
-	if (dhcp_pxe_options(options)) {
+	if (dhcp_pxe_options(options) || dhcp_timing_options(options)) {
 		free(options);
 		return CMD_RET_FAILURE;
 	}
diff --git a/test/dm/lwip_dhcp_options.c b/test/dm/lwip_dhcp_options.c
index 1d3923291bc..5fdeae6b2f0 100644
--- a/test/dm/lwip_dhcp_options.c
+++ b/test/dm/lwip_dhcp_options.c
@@ -8,6 +8,7 @@
 #include <lwip-dhcp.h>
 #include <malloc.h>
 #include <net.h>
+#include <time.h>
 #include <asm/eth.h>
 #include <asm/unaligned.h>
 #include <dm/test.h>
@@ -39,6 +40,10 @@ struct dhcp_options_test {
 	bool requested[256];
 	char hostname[256];
 	char vendor[256];
+	char discover_file[DHCP_FILE_LEN];
+	char request_file[DHCP_FILE_LEN];
+	u16 discover_secs;
+	u16 request_secs;
 	u8 arch[2];
 	u8 undi[3];
 	u8 uuid[17];
@@ -301,12 +306,18 @@ static int dhcp_options_tx(struct udevice *dev, void *packet, unsigned int len)
 	}
 	if (type == DHCP_DISCOVER) {
 		test->discover++;
+		memcpy(test->discover_file, msg->file, sizeof(test->discover_file));
+		test->discover_secs = ntohs(msg->secs);
+		/* REQUEST must retain the DISCOVER value despite this delay. */
+		timer_test_add_offset(1200);
 		/* An offer must not publish its metadata when the ACK omits it. */
 		return dhcp_options_reply(dev, msg, DHCP_OFFER, DHCP_REPLY_BASIC);
 	}
 	if (type != DHCP_REQUEST)
 		return 0;
 	test->request++;
+	memcpy(test->request_file, msg->file, sizeof(test->request_file));
+	test->request_secs = ntohs(msg->secs);
 	ret = dhcp_options_reply(dev, msg, DHCP_ACK, test->kind);
 	if (!ret && test->kind >= DHCP_REPLY_BAD_STRING &&
 	    test->kind != DHCP_REPLY_ZERO_OFFSET)
@@ -390,6 +401,9 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 
 	ut_assertok(env_set("ethact", "eth@10002000"));
 	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("bootpretransmitperiodinit", "5000"));
+	ut_assertok(env_set("bootpretransmitperiodmax", "60000"));
+	ut_assertok(env_set("bootpretryperiod", "10000"));
 	ut_assertok(env_set("bootp_vci", "U-Boot.test"));
 	ut_assertok(env_set("bootp_arch", "1234"));
 	ut_assertok(env_set("pxeuuid", "00112233-4455-6677-8899-aabbccddeeff"));
@@ -426,6 +440,9 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 		ut_assertok(dhcp_cache_check(uts, test));
 		ut_asserteq(1, test->discover);
 		ut_asserteq(1, test->request);
+		ut_asserteq_str("default.bin", test->discover_file);
+		ut_asserteq_str("default.bin", test->request_file);
+		ut_asserteq(test->discover_secs, test->request_secs);
 		ut_assert(!test->chain_failed);
 		ut_assertnull(netif_default);
 		ut_asserteq_str("1.1.2.3", env_get("ipaddr"));
@@ -489,6 +506,8 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 	*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_BASIC };
 	ut_assertok(do_dhcp(NULL, 0, 3, argv));
 	ut_asserteq_str("explicit.bin", env_get("bootfile"));
+	ut_asserteq_str("explicit.bin", test->discover_file);
+	ut_asserteq_str("explicit.bin", test->request_file);
 
 	/* Maximum option values fit; a larger value is rejected before sending. */
 	memset(long_name, 'x', sizeof(long_name));
@@ -561,6 +580,7 @@ static int dm_test_lwip_dhcp_options(struct unit_test_state *uts)
 		"bootfile", "timeoffset", "ntpserverip", "ipaddr", "netmask", "gatewayip",
 		"serverip", "tftpserverip", "dnsip", "dnsip2",
 		"bootp_arch", "pxeuuid",
+		"bootpretransmitperiodinit", "bootpretransmitperiodmax", "bootpretryperiod",
 	};
 	struct dhcp_options_test test = {};
 	ip_addr_t old_ntp;

-- 
2.53.0

