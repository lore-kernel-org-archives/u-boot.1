Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5EC606A336
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e3NEiLUO;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=kdmt7Tfa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CFE481423;
	Sat,  7 Nov 2026 14:33:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jDlfIE6C-DRg; Sat,  7 Nov 2026 14:33:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 11D8D81655
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061992;
	b=LnMdGtmrTtLPvCSakUiVB5zta6qr00OoBtcZSaiw16gBhV+vJ8YxeVTE3GiWC1Mzs9eW
	 oIeTKzhDL7ktZ56a3UwYyl1w+W3862anvJjwL6sqt230D8he8jl4crVydTZRum0qkc65z
	 oBD+n+Q3WHgRbeXPZNq7rk30toC2CnousPbW7JHY29i/uW+d+KeAZCQJr78Op1MvLxSjL
	 BDK13hXnBuLAsnOXweA7bnQWy7HdwmTAORAkXijI+jFZYKp43gbStKN9ECH2HCFYHK4F7
	 xzqu/U7Gz0qyR36XwdBHIr/aQijSH2ygycQeElLN/Z7Z/k/meNshVDD3kvwwTFv8mCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jpsp+aDk+l55C7UYy2EgSxKC6ZlreU8gWU4e/FApncQ=;
	b=ZAI3CAy01oHtN4qZKTFpjG9Uarpte/EbCuwtxxY78Pl7hy7Te/Zq2omk/mVkx1dM5L29
	 pps/d8V90Z44F9WaYxmfaYZQ7SUB1FejL5MWw/ftN8eDD+Z9Fq1m0MbzPu6D1HdaQhbLZ
	 FlsVfxCl4Ca+K66podopebu3YskyFBqGmrZxl/jwy841HjA+rYrURqzhitUYZteBYb7Vj
	 wjzDpnOfbZAe03yzl8c4F5KXpLVH304+mo6sxg3EV0QIaxTfUQJneZOa/Whj9Xgtk9x2g
	 9kKLbLdRbRQyP+xdTkJ9bDV5GTJzQgYXeEia01yZA8+uApTYe43HnpqRestPiXop9/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061992;
	bh=jpsp+aDk+l55C7UYy2EgSxKC6ZlreU8gWU4e/FApncQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e3NEiLUOb14L+3Pc/7MjxrXL1jPIdsBAliKqcj0Qh/BszbDKQrCD+Qw3Ji9EdJEQW
	 NVRa5zdePd4TI3z25NwdTDhEqe20W0VhSdu3kJV0K2SbAcRODcs7S2wC+fHlQXGLyg
	 525yT9/Z/PB7G4rGuuPI+QdZw9uLrEi2SJ1ft/y2xUuyDTL1p7Cb6FnqL3YheCpazt
	 sY46TR8cCoPokVJBigDOyUp2JcNVMgWCMdmT/fsUKrm2utMW7ffF2BaJLrrHe2DqGM
	 7Rn5vnYHPtaNZaF2/AVjCLxFPYkd6K0ypD1L6EG8ItHy5fkZn4RHudrXwc6m3cxDhN
	 Cw+SXJdwC9wGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11D8D81655;
	Sat,  7 Nov 2026 14:33:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BE9C4B8
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DFE6400E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGLe-Z_s1HK1 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D8E1E4009B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=kdmt7Tfa
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8E1E4009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:03 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso14915035e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061981; x=1794666781;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jpsp+aDk+l55C7UYy2EgSxKC6ZlreU8gWU4e/FApncQ=;
 b=kdmt7Tfaz0NEuGVQ/lQZzpiOelKN9HynaouXBcbjC/cHIcvkyg473OVKhOwGWjCbqQ
 fSXK1GurICbG87rT6vhFT54m+yWHIm9ejwlNySw1FWz/uabd1JjBJeb3znrW0Ug4dSJt
 QFnPVxt1W4mOGMq2hC3R87fNd+4TF6ZFX+u/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061981; x=1794666781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jpsp+aDk+l55C7UYy2EgSxKC6ZlreU8gWU4e/FApncQ=;
 b=HK6sCq0dY73JqcoLg9VKW7Rp3lr8cE+elOYfkPxkisuP2ysm5VjtZgK4O0ebBTSUpp
 y43ZPFw07bTd9LRq2NPErQTpGfTXUFjw38aM7EVxbka+ie6OS/1bztUXnXR+8VpczrL1
 BkxIHu4gXHgLPxqmDwgGNK2UwH0+LvRKAVgyHCV748ZBJCM3AyW/2cah/QZMq0HssLV5
 XL5KBgiw3FO3/jg6GtnAOEHGwIuRlNjrUE/5FHo8DoZ3d8PAi21vV1loLTi7iBynK2U3
 u1gr/AlA5IIYrjNGxBHgevciRo0x8wGY6PLxJO/InQFSUptUg8dwetLjCv8mm9SA+V6O
 nmKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVXulIdLXepVgkmDWvHxZqx2/HSSS/5ESuoR0IvoSeQ7zczU+ShDQiKuFT5GlKb1+Jj8F727c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8nvwSwfypwf3adKiY5C8seBfirE+RvH9eTsaCrylEM3wbeXHPw
 RqSyZ40Kzg6OBE2ihIf/KV7vQlpoPUqYbEcSuYdImU0mmHzuBBaelgElbRN8t4mT2Nw=
X-Gm-Gg: AYBFou1YW7fgdyOyEPEJBZ7p9VilXChEjG+pQ7LfP4IV2DcMlIkAoT086/O8QgKhl8b
 qE7MalIn2NMi680Mu9eUugS86xO/hOVnqERS2SKUq5emzpidETl2jfgUbwqo6sGAbIJp/ZZ4Ef6
 RYkIVxekkFvmD0M/zNrtzWpLpmplnePpaY6aZl+10rfh9X08pOOl20g8p4hv7rr2jSAJV/aL47X
 kUIixwnU0S41mBB66bUnSZfbjGv2u5aU0OrZeWdAcphacLtsQjI48XDCyDPdC+jdkgCcGJC+2mb
 0Y+ElROBHtnDry5lcflGHbQTjDxPuwhwTnF9WR2LU+P0TTf74ounc7w4U98z42y4PsfpL6DumMP
 adSATvbvHcTG1vxx3B7CnveploG2WWsB/lCI/XOqBjRCbTLLZlEoKpKy86ntQUDeczBF9BcoI2L
 GPFdT4FGsVfV3bjw13gDRqOLSj5983/k1zBa6TCx94Ql7hF0yybEE9BaG1e80wmb/tTWggEovJt
 dzYIfS/Tm/Fsszomoxv6btVIHYq4FIAIL246IEgn2hL4NbQ9Nbl+OxUkiNdgDhzib+bBbqtXxhv
 Bl7+YYDzCQvXotS4QonKORjvM9miDd9UjBJEmIuMlWgqx9rKDfD8HrOA3Yp/y8gobPgqNLyNXhQ
 CgImUQt7a6rB1cRAV3JvWoEJQaSpX9K4pZEnGuKVuYUSIZ0AFK45vs9WLRYsRbJI7hCTOA8O/ur
 c/zc6uuS+Yl/wKlTPyjSLIL87YjjM=
X-Received: by 2002:a05:600c:6090:b0:4a3:598e:e7a8 with SMTP id
 5b1f17b1804b1-4b6db0d0817mr92208735e9.4.1794061981475; 
 Sat, 07 Nov 2026 06:33:01 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:00 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 08/35] arm64: dts: st: add can1 pins for stm32mp25
Date: Sat,  7 Nov 2026 15:31:58 +0100
Message-ID: <20261107143241.2236511-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the can1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-9-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: b9efa6d3c580feeb4af6204457ce3ebf351b2af4 ]

(cherry picked from commit e9b8701fc994a04a4dcd15598de7bbd9d81ecfe9)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 50f454630cf2..6482dd47e977 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -331,6 +331,28 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	m_can1_pins_a: m-can1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 9, AF7)>; /* CAN1_TX */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 11, AF7)>; /* CAN1_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	m_can1_sleep_pins_a: m-can1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 9, ANALOG)>, /* CAN1_TX */
+				 <STM32_PINMUX('B', 11, ANALOG)>; /* CAN1_RX */
+		};
+	};
+
 	/omit-if-no-ref/
 	ospi_port1_clk_pins_a: ospi-port1-clk-0 {
 		pins {
-- 
2.43.0

