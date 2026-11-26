Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A7E606A330
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cfP+WPVV;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ql3OSQeg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E51EC60A71;
	Thu, 26 Nov 2026 13:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KjlaBMTM3I2A; Thu, 26 Nov 2026 13:33:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27EB960AA2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700011;
	b=OXiVvr4/XQZsM9eydotwSv2ywh0Rhv8dH8KL7jYHtD1jrlqtMU41yiXaUGp7/obTfkKR
	 RJx6u2+k7NJhbRsJr+fD6vLMMKmB8UyNDXTikuaVnve9tCd2+foQskcGwE6d9tsuVMgYV
	 z+fV1rpcalRHwfMMCMRpAHurfw4I20jejn30Irbe+j/Z3+2YqTtsuJncHKGCpKwrAEVN1
	 MH1TgeK/gQMBeg+vwFlE237H6zUvGkzz8EEr68x7LXbsfwUY+kyVs/ehTSm/CWb0dBfo/
	 MJuqTaFD3DlIFR4kuLBimkmXSoHx+1knOTwJpQuQlnjSK1aqGEhXIywcI/YFHBLLSpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UYs9LM4r9QZ/y/Rp6d0s1FciVwKGfziNI7utcSa36aE=;
	b=SfWggr3oEg3qOAvzaPd0q/mRlpKa+IJSKQT2MQUMDe1Dv3sc2z5c5TQYq0eLnpTgx/st
	 qxAx1h8xDQrWf2yEW7UyGrFvm/lTUFWT9HEJAEPQfmSM+/JL3H2p3ZlzNynFa7lYD4kHB
	 Zm9mHUSfsheQxOM0N2jQLHTugkjql+ZbYzRZ6CKRBYxJhHjy9eOdB4kKq7oZaDwU2Y0BF
	 1PDX458eoe9GppLZNTJW8S0+4JlLpjZOss2RTUaiqK7rLvEBKpASbldxuF6lVJHhUOX+s
	 H/u1H/ARX+T0aEEg4BSV0vIRK/DJGcv3Dn7GpeP9lDk5SO+92gjsBfmC897+gX2Btfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700011;
	bh=UYs9LM4r9QZ/y/Rp6d0s1FciVwKGfziNI7utcSa36aE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cfP+WPVVTruf0DP1rcUZXzSYcfvpiXMMVsq1EVTlOVqxm95JuYfD+AZePLPewz9WA
	 81snsogFMTCmw1HoHn9htwgROYGChdfiEFEQ8kqv+oB2U1CJniua4KqT5CWuhvXAAN
	 0XvITjkwTMQ748s8XzodCzqjOadmGha3K2Y+9zI3lOlcJP0EFB+bPcuRPksankp6xA
	 Z+4UeiUga1HctJ8LbvZbl5cy9RW0TBq83jvVQy31HT75WWLKansKT3HtmvvNO28YfE
	 GWnubbXAMUDWYHOrVBlFMmF+JVi8wmJ/2S+B2Bz793C2NfHb4tYXhMeqdDIX7qVAxv
	 7q1vTbviDAqYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27EB960AA2;
	Thu, 26 Nov 2026 13:33:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBAC022B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C17EC4079A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WR8bLcRlkiJt for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0291E4084E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Ql3OSQeg
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0291E4084E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:20 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-862b98b2e47so2621573a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795675999; x=1796280799;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UYs9LM4r9QZ/y/Rp6d0s1FciVwKGfziNI7utcSa36aE=;
 b=Ql3OSQegNc19MO8/N/M9UAA61/fEJAfndnvfPBm40lD65r+O81rDv4VXxdUIX5GAo0
 EIgeubDxJIJbzTU8Kt/FH7xPFcsCA0xion0Pqp5QWPJdK27JZUACYznSrw3uZQeEf/SG
 rmjVmCa1ToBhdLnbljy36l2JgPHFo37x26G5+eHJ6ikzS047MNMbgS4dgyZOAAXPtAL9
 Oi94aXqmF0tu6CbzhF3YKwRQMY06UBKWOvOb4df9fVJI9GlHLDsZJG21xVZOZIo57ZT2
 qTZ8oifLcSqtmICb2Oxr3xMyNzWFsLZIgDWKRvh2fFT8DWb1mOk/NCsp9D6RMxq2nDmZ
 Gr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675999; x=1796280799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UYs9LM4r9QZ/y/Rp6d0s1FciVwKGfziNI7utcSa36aE=;
 b=xSYrgexWW/JhVZE4lxUB21wa2ulqSB1/ZWbifDxexx5xJwfFf6h8Ih81mwnQvbhbUJ
 llCO84P/twpuMVZAK6gcB0BE+8IvGUMLkh1onHFtso7CLVV5H4D9237PJYuRWNt1JGIQ
 q8ZucHoUtpQqEmXQqWBf5ufiaULBLfF9BWw5WucHHwZi3IVEeZYl4I02hF4+Xukhtx89
 FMiOGRqREXKDJ0wIF3Xr836w+AbAUQGy50py9XyMjnK2Xs0MF2huTJE7NsHa/jB6rWiv
 sM4epOkqpMxt12mUwPdwVhvf9LP9dzFxuo6fbf/27FvQTQfMSH6TOTixJDhVNEh6AtOo
 V/wA==
X-Gm-Message-State: APuU4Z+wisygaMMsVoOvdzk028ufVS/A572vmop8O8wjytznMICpP2RB
 G/YZimxkM31gqp/1dvlHm/Csg6MvDF/Kxfb+syiDFzGjpI0QBfyFXTI+
X-Gm-Gg: AZFdTZcuDg/GT+25BgbOjfpOe40d5oq57u7wCvf74oO8fVmHe7pphCmJ6Fh/+vUzIqC
 EJvtNA4zLsu24XbxEIBBbGEN1D0UDZ1/cHlqlm8rO4Xk1W8UsZ+d0dZ+E1x+3alba6tjWJuTHSi
 MEhlF1/3+ZF7b979Mo7yyMVT5iAjhiWbvlMn1THyGtVSGLNoWsRwqbVellYGc5LRwfBc1Wm1y0v
 3F2veNjq5Qw1HPYY0v6id4R+RN7NOS8ff6UCN9lJz+0CDUc3OR1j0uYaveSItuEYNuT7Wa+LDbw
 a014iQxIVUe3RNOYJ9N1eKfqImqbie/MfXQXuUHWZmU2gK5dG2zKiUe13fa8QQUUPZzX8Yp5xv9
 3JQMMZepYahanWX4S00xIKZvsdcs+5uNihUGj/y/t/HBbxdWJYjgdAyLepX7fr3aD7Xm8IKkMur
 AWflGg4+wwE/5Cnd2v11dmyrm6oRf/jw6xqPiM/cpokkt9C438ntSLnJ/NhdJCP5wLgIE1hhhU+
 1ZfhzXIIykiuZV3TbPFo3kJuS8BoFK7WF3nYDSgmqjqLwhIGCPDf2j8kyOimyGqhcougzE+qxyz
 +Ed/Tmr6IX5B/3s3mlAlZfq3LY/K8Xoecwjwha/GCJ1e4ijVCbXGk3O8cGFhCqnYTCUiadt1hrj
 qopiVxQKIxVwP+vpSpzmTdMYnbPOb0PvmdMxMmoiqri347DSIS1caDZHQ7LagLsCOlEUeiKOjsp
 37Rq1L4AVFCHwTuKawjEfc0+HTZnEhQL1rPak9u3+tldlnrJgH1KM=
X-Received: by 2002:a05:6830:448d:b0:85f:1601:d3 with SMTP id
 46e09a7af769-863157af868mr21273491a34.23.1795675999535; 
 Wed, 25 Nov 2026 22:53:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:55 -0700
Subject: [PATCH 06/19] net: cdp: calculate checksums from network-order bytes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-6-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
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

Switches can send CDP advertisements with an odd payload length. The
final octet contributes to the low byte of the checksum word, even
though complete words use network byte order. Summing native-endian
words gives the wrong result for these packets on little-endian systems.

Read the words in network order and apply CDP's one's-complement
correction when the final octet has its high bit set. Use the same
calculation for received advertisements and outgoing triggers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/cdp.c | 65 +++++++++++++++------------------------------------------------
 1 file changed, 15 insertions(+), 50 deletions(-)

diff --git a/net/cdp.c b/net/cdp.c
index bcea5887bc2..57c3080d121 100644
--- a/net/cdp.c
+++ b/net/cdp.c
@@ -35,60 +35,25 @@ static const uchar cdp_snap_hdr[8] = {
 
 static ushort cdp_compute_csum(const uchar *buff, ushort len)
 {
-	ushort csum;
-	int     odd;
-	ulong   result = 0;
-	ushort  leftover;
-	ushort *p;
-
-	if (len > 0) {
-		odd = 1 & (ulong)buff;
-		if (odd) {
-			result = *buff << 8;
-			len--;
-			buff++;
-		}
-		while (len > 1) {
-			p = (ushort *)buff;
-			result += *p++;
-			buff = (uchar *)p;
-			if (result & 0x80000000)
-				result = (result & 0xFFFF) + (result >> 16);
-			len -= 2;
-		}
-		if (len) {
-			leftover = (signed short)(*(const signed char *)buff);
-			/*
-			 * CISCO SUCKS big time! (and blows too):
-			 * CDP uses the IP checksum algorithm with a twist;
-			 * for the last byte it *sign* extends and sums.
-			 */
-			result = (result & 0xffff0000) |
-				 ((result + leftover) & 0x0000ffff);
-		}
-		while (result >> 16)
-			result = (result & 0xFFFF) + (result >> 16);
+	ulong result = 0;
 
-		if (odd)
-			result = ((result >> 8) & 0xff) |
-				 ((result & 0xff) << 8);
+	while (len > 1) {
+		result += get_unaligned_be16(buff);
+		buff += 2;
+		len -= 2;
 	}
+	if (len) {
+		u16 last = *buff;
 
-	/* add up 16-bit and 17-bit words for 17+c bits */
-	result = (result & 0xffff) + (result >> 16);
-	/* add up 16-bit and 2-bit for 16+c bit */
-	result = (result & 0xffff) + (result >> 16);
-	/* add up carry.. */
-	result = (result & 0xffff) + (result >> 16);
-
-	/* negate */
-	csum = ~(ushort)result;
-
-	/* run time endian detection */
-	if (csum != htons(csum))	/* little endian */
-		csum = htons(csum);
+		/* CDP treats an odd final octet as a signed one's-complement word. */
+		if (last & 0x80)
+			last = 0xff00 | (last - 1);
+		result += last;
+	}
+	while (result >> 16)
+		result = (result & 0xffff) + (result >> 16);
 
-	return csum;
+	return ~(ushort)result;
 }
 
 int cdp_build_trigger(uchar *frame, const u8 *src)

-- 
2.53.0

