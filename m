Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D79C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 17:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B59481113;
	Thu,  3 Sep 2026 17:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ky7YzALVhKw9; Thu,  3 Sep 2026 17:09:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 46B4281118
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788455376;
	b=cRSL496sKBhS9cjj6DDc9Uoor0X+TvExPItrPnfSMe/pv4CIfPH4MZ/YGn8kIR8LNQ+s
	 flYX9Y+qAbssHWeofvQVPwAGXPvRzAwTktBFPtT3ggLHKczlqYwQNlDmLwdpMYDz4QaG8
	 nvqifIzAc6ftH7epHrUPfJWKE+3/Gf7i3JvDYfYrKxpeXuMmR9ZOPC988TQpQNm0evsJc
	 chG0O67O8P2am1M6lBZ6R28Gng17JlKIfrJASoLWYS+4fSpRXV1fyDucSjGUJYO9GhbRB
	 hE02rZT5QxC5enfLGqT/7eo9PhjbHI0yes54tsrwRA1wFqpW7oPzWla298e5UNNbzcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788455376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=G5JLhweYJFmf9A6ofuDSIgOPwbj7J4jtJrQ9Hj788T4=;
	b=L/d5nBA1E5VWjDdS3jL96KDvlF8yzW83OlN0vyZPpc1BfkSijLAwWdaYWsgWLmBAaTqJ
	 35OadqLLmkH1DBgEAA7UH7Bvg8JgXxXjCGqhkpva3QLbRuBSRkp/77IU9fFGIZIfAR2VG
	 ykQMIjMChcpQknPvW/LwvbmKX1tAwTcoCrZ29nj3hB8GOgeuFC7Xo1wRVarKMRZ4apJPg
	 oSMryKGCDCEXFddXWQqDYTeSJaBdeRtzk4iwtxd07wJlAvVaCV1H/ImnWv/BlyObXE6Rk
	 RBXUlTxM/3L4zwvM5FNQJfD1zzBGchii8zorhS4fPSBGE+r6F3ohlRG/Q23Au6apa2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788455376;
	bh=G5JLhweYJFmf9A6ofuDSIgOPwbj7J4jtJrQ9Hj788T4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bHG1cZy9f2VgQcTZZlpVCAYzGYKcdfRkUksPqMSDx5zAn/wdffZ/mq0sJlScDYrbx
	 +4sfWyQwJHl7hZA1XUreYKjd1a1miQg0elibGFGA6NtwnuXCqAld27css7X87dt/yh
	 E9lfipsPxmvoLGaVqmb6BH6ewIPyDfyv+yN/T1pfWZ0869JYYVkk8YvUC2/ozhPaKv
	 NFzfv7q5F6vysXqrCEVk36hgGr2ISwnLsEJQPFozTnefAazXl/lwJNSY+1iXoGqp9b
	 DNU3EeT9Wftm6EjNVi19xTomOVhs7UqL6CGAnwW2vRHKjFezr83d+87C08tEk/9cWW
	 ZYsE+63i9pJQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46B4281118;
	Thu,  3 Sep 2026 17:09:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 95B0A34E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 17:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B53A60B64
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 17:09:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vyT78BQDuV9n for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 17:09:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 50E1D60B4F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788455373;
 b=i34zNOHjONtuWM3Fks6afEJsezmiJZdJVShtRK2ixRXBmH+vVSpQYHWx8ewjRQNJJtjS
 o700r3GrXVhoAeGnmpb+vlSrFiJQIDgJse6E+s8ZemYitLvxoOHdIU9qIrSEkAjpuwb9v
 uvLXhz7OMJVleJr7ki+7kUFX0pj6r1vTo4uFtFMvZDFClz8DrG6dZLbZY9PRmbQ8NAE+e
 EvZKHyCPUvVSxH47hkotgMMawPWwWx4GBuuvPNSDxOfaQ41Mc60KBP2LXbjWoNoh4hVWJ
 x4FhEscQyG3JoKlNe587mEeAEbbphl9DLhlDZJntZG1hzsKtKiI/FLmQEnvtgWTfY6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788455373;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=G5JLhweYJFmf9A6ofuDSIgOPwbj7J4jtJrQ9Hj788T4=;
 b=lam2X9/66TLvRr8L+rUvQsxFp6Il2ACM9PE1VMyLH0xVl0NI+LD/wi+y8wg9/8fDz3VE
 qp6YgGhZBbu0JhxnhAE3dIgr3Q+HG9oYU9f9zb1DEAfAbcR9ryskpAwa65io7k+S9BOMp
 aoUfUKLHWl06gXcRHCA2/nMNRa4VHgTNpFtfFQA3d1hmYwbx+h2bkIqwJq/Y2991f21bB
 ICJuxN1xwjIRDVvfOjoDNLUsgoejTPC3Vux5KbGBcv9CuebAqFxly/d1xbYXOvIRBmZ5s
 /ls9D+Zs0c7SsvHdbrOBZrTVftScxJ9B8KJTYwPsLdcaHblmBK5hH1QheaTbTv9PSbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="MRx63XA/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MRx63XA/
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50E1D60B4F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 17:09:32 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so68137a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788455372; x=1789060172;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G5JLhweYJFmf9A6ofuDSIgOPwbj7J4jtJrQ9Hj788T4=;
 b=MRx63XA/20kTqMnfh7hQ6p6yg9UWv7XEfoZw1UCPrQA97Y8iu0NPZX47/AejltrT6n
 C6rZSBRDU0D6zoNBztq8e/cpr5VE/PJbiG3nrcc83WTgght4qBtoJoS6Sv8zWpWr2+Oo
 zfAuE68mtEDo92nsYWe/cDqmoMs/ykAuAwdHt3uzpUm6I9UICdoIYm+5TkM0Tg7QaZyX
 JqEdj5D2BbPyjHrkHWGnRp95g+7GndHIy/BKpC4bWzQpiWmOLO7C7X5n0FU7mv1KL6Z9
 lOESB8LATIqQyCyBvubiDcKmIVtrMTIMPB6yA53a4+L/ksR3/fMO8QUQ3QkXXs3MXBED
 GVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788455372; x=1789060172;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G5JLhweYJFmf9A6ofuDSIgOPwbj7J4jtJrQ9Hj788T4=;
 b=DUh1fRChf9L9GXbqCFbCAWgjqV+JwsEU0Z6PtgPrzeyu1RxSQ04ml81AqKNxDp4fZW
 aD5001M9rssJI3U2NktIC4szgNjX+AzhrSx6LnpG2PKKhbysWWOB6UfpTsTJt6t+vcmW
 n9xmy5XfHh4HH8hYNWI1q5I51ksUXvqDogEzu2CoJX9xxvcx+pnI4TvZCpWaBoNXssVl
 UQ7fzBo1SILz23kJ9qEm2vlgBWAU/q3jOv+d1K/bqB3NH3KLVsCnAhhjiZYUjVEbcqGR
 DPILsWtIVw3VeJVSzNuGnAbPbFC308Wa0XXguffos1cch2OH8zFHYGLgt7BoPdxDdSqB
 Zurg==
X-Gm-Message-State: AFuF++mKYboiPj1Q72TclpouGxBYYtXa2rJGrbgqhE4GTSQ/UgnAbq6f
 i6c4IRFz73uCwt7Yu/C6qpe5k3nISZsfMrcMomKAlfP3Ql/A6gC1SyVu4A8Ygg==
X-Gm-Gg: AYBFou21pbs61lY7+sKLEjVppNsDvKUx972YdXGQJhuRw15kgjeIzadTAu2USV5rM3f
 7sagxY5EzxPTXYdzjAX55zBUK/1t8J4Jal+VUwisxj2FlkbnDUuyKMY9oxspArk9gZ6Ts/nlcq+
 y1CykEOb/4oumeqnaSX7WLsfmQ+3Ld1e27kIYIW279UHuopJBsKDpS4nTMm3yw2CMdFv2se1bEp
 FhG+omw0FkiJMP0vmSBjdztFksDQMQzi0CG3iMTfFRzyqtf3oiPJMkwfKrt+4/vS9pccTMalKVl
 AxVHZbTO8ishnLuJDU38BRsNLteT43Bv58fLUDlei02QS7N86I7fkYWMWEErWEZ3p+ir9SwIZAt
 F1u0YTTh2uR0EwF0Qewd+iiBHxPO9NXwpfJ5om5A/s8/BgcnlAAEX5QXzT7udmaNwpqogRXI1Bo
 6dTWb386iS+nb8jj+7koES1CYzwZLDjKlZENnWWvzMmvh6D0nNQfNGQliGQLd+D7JVzdH7dZVCN
 7cIDFLNw1HMLHKW/lIfXHqq6suquxOPIxAV021bH5fzA5LtzBAZH+urt6lDL2tRdPKfXdFq+umd
 ycpEsO1ATiQlUpBvmxQAnNZZiynTckp7HMGfJowOm0iz87Geib3LZd8VgaPs5OWgG08lsZKgIYK
 mUu18QKQv4Vmd+MOI6g==
X-Received: by 2002:a4a:ee0d:0:b0:6b4:4f54:fd07 with SMTP id
 006d021491bc7-6b6fa5e8c58mr177067eaf.7.1788455371730; 
 Thu, 03 Sep 2026 10:09:31 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6de522bb0sm456881eaf.13.2026.09.03.10.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 10:09:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 03 Sep 2026 11:09:25 -0600
Subject: [PATCH v2] net: sandbox: support raw Ethernet with lwIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-submit-lwip-sandbox-raw-v1-v2-1-206bb597fb4e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6CMBBGr0K6dpQiILjyHoZFCwOMsS1p+TOEu
 9viBUxm8+abefk25tASOnaPNmZxJkdGe0hOEat7oTsEajyzJE7yuEgycJNUNMJ7oQGc0I00K1i
 xwMzhlpZXnsUpl0XOvGCw2NJ6yJ/Vj/33C+sxGMOFFA5BWqHrPqymwY0WhbooQTrkPbnR2M/Rb
 ubB81cRPxzaMsuKVqZt3vBH543vc20Uq/Z9/wI2Auyv9gAAAA==
X-Change-ID: 20260825-submit-lwip-sandbox-raw-v1-749315041b86
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, 
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

ETH_SANDBOX_RAW is restricted to NET_LEGACY despite operating through
the common Ethernet driver API.

Make the localhost shim stack-neutral: define the ARP layout locally,
populate lwIP's per-device ipaddr environment variable, and retain the
legacy address state when that stack is selected.

Linux loopback can expose UDP checksum-offload seeds through raw sockets
without the metadata needed to validate them. Normalize these to the valid
IPv4 no-checksum form. Only update the dummy UDP bind for UDP output so
lwIP-generated ICMP packets cannot disturb it.

This enables both real-interface and localhost raw Ethernet with lwIP.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - skip non-initial IPv4 fragments when parsing UDP headers  (suggested by Jerome Forissier)
  - avoid overwriting ipaddr for indexed lwIP devices  (suggested by Jerome Forissier)
  - Link to v1: https://patch.msgid.link/20260825-submit-lwip-sandbox-raw-v1-v1-1-f9558fb4f6d1@gmail.com
---
 arch/sandbox/cpu/eth-raw-os.c | 85 +++++++++++++++++++++++++++++--------------
 drivers/net/Kconfig           |  2 +-
 drivers/net/sandbox-raw.c     | 52 ++++++++++++++++++--------
 include/net-legacy.h          |  6 +++
 include/net-lwip.h            |  5 +++
 5 files changed, 107 insertions(+), 43 deletions(-)

diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
index 39ea3b3f012..42f291a5519 100644
--- a/arch/sandbox/cpu/eth-raw-os.c
+++ b/arch/sandbox/cpu/eth-raw-os.c
@@ -208,7 +208,6 @@ int sandbox_eth_raw_os_send(void *packet, int length,
 			    struct eth_sandbox_raw_priv *priv)
 {
 	int retval;
-	struct udphdr *udph = packet + sizeof(struct iphdr);
 
 	if (priv->sd < 0 || !priv->device)
 		return -EINVAL;
@@ -226,38 +225,51 @@ int sandbox_eth_raw_os_send(void *packet, int length,
 	 * stack from sending that ICMP message claiming that the port has no
 	 * bound socket.
 	 */
-	if (priv->local && (priv->local_bind_sd == -1 ||
-			    priv->local_bind_udp_port != udph->source)) {
+	if (priv->local && length >= sizeof(struct iphdr)) {
 		struct iphdr *iph = packet;
-		struct sockaddr_in addr;
+		unsigned int iphdr_len = iph->ihl * 4;
+		struct udphdr *udph;
 
-		if (priv->local_bind_sd != -1)
-			os_close(priv->local_bind_sd);
+		if (iph->protocol != IPPROTO_UDP ||
+		    (ntohs(iph->frag_off) & IP_OFFMASK) ||
+		    iphdr_len < sizeof(*iph) ||
+		    length < iphdr_len + sizeof(*udph))
+			goto send;
 
-		/* A normal UDP socket is required to bind */
-		priv->local_bind_sd = socket(AF_INET, SOCK_DGRAM, 0);
-		if (priv->local_bind_sd < 0) {
-			printf("Failed to open bind sd: %d %s\n", errno,
-			       strerror(errno));
-			return -errno;
+		udph = packet + iphdr_len;
+		if (priv->local_bind_sd == -1 ||
+		    priv->local_bind_udp_port != udph->source) {
+			struct sockaddr_in addr = {};
+
+			if (priv->local_bind_sd != -1)
+				os_close(priv->local_bind_sd);
+
+			/* A normal UDP socket is required to bind */
+			priv->local_bind_sd = socket(AF_INET, SOCK_DGRAM, 0);
+			if (priv->local_bind_sd < 0) {
+				printf("Failed to open bind sd: %d %s\n", errno,
+				       strerror(errno));
+				return -errno;
+			}
+			priv->local_bind_udp_port = udph->source;
+
+			/**
+			 * Bind the UDP port that we intend to use as our source port
+			 * so that the kernel will not send an ICMP port unreachable
+			 * message to the server
+			 */
+			addr.sin_family = AF_INET;
+			addr.sin_port = udph->source;
+			addr.sin_addr.s_addr = iph->saddr;
+			retval = bind(priv->local_bind_sd,
+				      (struct sockaddr *)&addr, sizeof(addr));
+			if (retval < 0)
+				printf("Failed to bind: %d %s\n", errno,
+				       strerror(errno));
 		}
-		priv->local_bind_udp_port = udph->source;
-
-		/**
-		 * Bind the UDP port that we intend to use as our source port
-		 * so that the kernel will not send an ICMP port unreachable
-		 * message to the server
-		 */
-		addr.sin_family = AF_INET;
-		addr.sin_port = udph->source;
-		addr.sin_addr.s_addr = iph->saddr;
-		retval = bind(priv->local_bind_sd, (struct sockaddr *)&addr,
-			      sizeof(addr));
-		if (retval < 0)
-			printf("Failed to bind: %d %s\n", errno,
-			       strerror(errno));
 	}
 
+send:
 	retval = sendto(priv->sd, packet, length, 0,
 			(struct sockaddr *)priv->device,
 			sizeof(struct sockaddr_ll));
@@ -283,6 +295,25 @@ int sandbox_eth_raw_os_recv(void *packet, int *length,
 			  (socklen_t *)&saddr_size);
 	*length = 0;
 	if (retval >= 0) {
+		if (priv->local && retval >= sizeof(struct iphdr)) {
+			struct iphdr *iph = packet;
+			unsigned int iphdr_len = iph->ihl * 4;
+
+			if (iph->protocol == IPPROTO_UDP &&
+			    !(ntohs(iph->frag_off) & IP_OFFMASK) &&
+			    iphdr_len >= sizeof(*iph) &&
+			    retval >= iphdr_len + sizeof(struct udphdr)) {
+				struct udphdr *udph = packet + iphdr_len;
+
+				/*
+				 * Loopback packets can retain a checksum-offload seed
+				 * which a raw socket cannot validate without skb metadata.
+				 * An IPv4 UDP checksum of zero explicitly disables the
+				 * checksum, so present that portable form to U-Boot.
+				 */
+				udph->check = 0;
+			}
+		}
 		*length = retval;
 		return 0;
 	}
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index faa08e9ebba..c057504cf66 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -366,7 +366,7 @@ config ETH_SANDBOX
 
 config ETH_SANDBOX_RAW
 	depends on SANDBOX
-	depends on NET_LEGACY
+	depends on NET
 	default y
 	bool "Sandbox: Bridge to Linux Raw Sockets"
 	help
diff --git a/drivers/net/sandbox-raw.c b/drivers/net/sandbox-raw.c
index c3d40f0b59e..f62758e6d44 100644
--- a/drivers/net/sandbox-raw.c
+++ b/drivers/net/sandbox-raw.c
@@ -13,6 +13,21 @@
 #include <malloc.h>
 #include <net.h>
 
+#define ARP_PROTOCOL_ADDR_LEN	4
+#define ARP_OP_REPLY		2
+
+struct sb_arp_hdr {
+	u16 hrd;
+	u16 pro;
+	u8 hln;
+	u8 pln;
+	u16 op;
+	u8 sha[ARP_HLEN];
+	struct in_addr spa;
+	u8 tha[ARP_HLEN];
+	struct in_addr tpa;
+} __packed;
+
 static int reply_arp;
 static struct in_addr arp_ip;
 
@@ -20,16 +35,23 @@ static int sb_eth_raw_start(struct udevice *dev)
 {
 	struct eth_sandbox_raw_priv *priv = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
+	char ipaddr[sizeof("ipaddr99")];
+	int idx = dev_seq(dev);
 	int ret;
 
 	debug("eth_sandbox_raw: Start\n");
 
 	ret = sandbox_eth_raw_os_start(priv, pdata->enetaddr);
 	if (priv->local) {
-		env_set("ipaddr", "127.0.0.1");
+		if (!IS_ENABLED(CONFIG_NET_LWIP) || !idx) {
+			env_set("ipaddr", "127.0.0.1");
+		} else if (idx > 0 && idx <= 99) {
+			snprintf(ipaddr, sizeof(ipaddr), "ipaddr%d", idx);
+			env_set(ipaddr, "127.0.0.1");
+		}
 		env_set("serverip", "127.0.0.1");
 		net_ip = string_to_ip("127.0.0.1");
-		net_server_ip = net_ip;
+		net_set_server_ip(net_ip);
 	}
 	return ret;
 }
@@ -44,13 +66,13 @@ static int sb_eth_raw_send(struct udevice *dev, void *packet, int length)
 		struct ethernet_hdr *eth = packet;
 
 		if (ntohs(eth->et_protlen) == PROT_ARP) {
-			struct arp_hdr *arp = packet + ETHER_HDR_SIZE;
+			struct sb_arp_hdr *arp = packet + ETHER_HDR_SIZE;
 
 			/**
 			 * localhost works on a higher-level API in Linux than
 			 * ARP packets, so fake it
 			 */
-			arp_ip = net_read_ip(&arp->ar_tpa);
+			memcpy(&arp_ip, &arp->tpa, sizeof(arp_ip));
 			reply_arp = 1;
 			return 0;
 		}
@@ -68,7 +90,7 @@ static int sb_eth_raw_recv(struct udevice *dev, int flags, uchar **packetp)
 	int length;
 
 	if (reply_arp) {
-		struct arp_hdr *arp = (void *)net_rx_packets[0] +
+		struct sb_arp_hdr *arp = (void *)net_rx_packets[0] +
 			ETHER_HDR_SIZE;
 
 		/*
@@ -80,18 +102,18 @@ static int sb_eth_raw_recv(struct udevice *dev, int flags, uchar **packetp)
 		 * to get a response. For this reason we fake the response to
 		 * make the u-boot network stack happy.
 		 */
-		arp->ar_hrd = htons(ARP_ETHER);
-		arp->ar_pro = htons(PROT_IP);
-		arp->ar_hln = ARP_HLEN;
-		arp->ar_pln = ARP_PLEN;
-		arp->ar_op = htons(ARPOP_REPLY);
+		arp->hrd = htons(ARP_ETHER);
+		arp->pro = htons(PROT_IP);
+		arp->hln = ARP_HLEN;
+		arp->pln = ARP_PROTOCOL_ADDR_LEN;
+		arp->op = htons(ARP_OP_REPLY);
 		/* Any non-zero MAC address will work */
-		memset(&arp->ar_sha, 0x01, ARP_HLEN);
+		memset(arp->sha, 0x01, ARP_HLEN);
 		/* Use whatever IP we were looking for (always 127.0.0.1?) */
-		net_write_ip(&arp->ar_spa, arp_ip);
-		memcpy(&arp->ar_tha, pdata->enetaddr, ARP_HLEN);
-		net_write_ip(&arp->ar_tpa, net_ip);
-		length = ARP_HDR_SIZE;
+		memcpy(&arp->spa, &arp_ip, sizeof(arp->spa));
+		memcpy(arp->tha, pdata->enetaddr, ARP_HLEN);
+		memcpy(&arp->tpa, &net_ip, sizeof(arp->tpa));
+		length = sizeof(*arp);
 	} else {
 		/* If local, the Ethernet header won't be included; skip it */
 		uchar *pktptr = priv->local ?
diff --git a/include/net-legacy.h b/include/net-legacy.h
index d3b122c9062..2737b683cb1 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -288,6 +288,12 @@ extern char	net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN];	/* Our root path */
 extern u8		net_ethaddr[ARP_HLEN];		/* Our ethernet address */
 extern u8		net_server_ethaddr[ARP_HLEN];	/* Boot server enet address */
 extern struct in_addr	net_server_ip;	/* Server IP addr (0 = unknown) */
+
+static inline void net_set_server_ip(struct in_addr ip)
+{
+	net_server_ip = ip;
+}
+
 extern uchar		*net_tx_packet;		/* THE transmit packet */
 extern uchar		*net_rx_packet;		/* Current receive packet */
 extern int		net_rx_packet_len;	/* Current rx packet length */
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 8e59a2299e0..9b7755e335e 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -26,6 +26,11 @@ enum proto_t {
 	TFTPGET
 };
 
+static inline void net_set_server_ip(struct in_addr ip)
+{
+	/* lwIP reads serverip from the environment when starting a command. */
+}
+
 static inline int eth_is_on_demand_init(void)
 {
 	return 1;

---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260825-submit-lwip-sandbox-raw-v1-749315041b86

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

