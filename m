Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F41C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F00F80CA3;
	Wed, 26 Aug 2026 05:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NpGed27khQ1d; Wed, 26 Aug 2026 05:30:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722241;
	bh=VvmlYc4uR60GhmkrwN/xcN5jfUNAxmKzvS90Ij+le74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mWKu9K91EeRUPfWSs6XCoELq0wLaFUmmNKDFvuxvNjggbPrrpkOZzmyD5DtmIeYAY
	 8L54Iu+5S++GFbvWKUjtYKagLaE3gfV/PY0HmJcgLLGgKKG8XXNMjSTpcBYbD1im9X
	 7bEM1d2bYqckHE54ZG25r5TbqZbNIxZqZpXznNE0XApk3NaJGxrrWTvKHlaaoFHwhq
	 +q7T6MAv2Cz+7kUwubYX4q3aV1ibw2xPURjBe7RIqSgx7fWkvJ1F5cqDi7Wmo1KJW7
	 vVwJspTPlhlumofQ/8sCXYBjNkvFJ2Zh/KDVuS0vjSne18nw/kIYp0lxy9TxObXi6N
	 tN8A1hOljwVAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BE3980C0C;
	Wed, 26 Aug 2026 05:30:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 409B22FD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32D8D40073
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cTeR8ffVQpjP for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:30:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Zf1lgyf1
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F91A4000B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:29 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-45e2fd33133so552513fac.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787722229; x=1788327029;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VvmlYc4uR60GhmkrwN/xcN5jfUNAxmKzvS90Ij+le74=;
 b=Zf1lgyf1YTWt7aBNJiJbp6T2RnOnvyIxr6YdbLr2Ryr4BsJ/22dJAlw3cdjDYY0yd7
 AACuXoYbIq1lkubFp3YMHHvTO6a9ZpH27dnBO0bz/Vnv/neaRXdw15DnicjEKFshczQp
 IXa/03464Q72dVVS2YJvyke1B3HnjY2QH52TBfP2Tgu14DYNHQKdBY70h7lzvqe+2o9i
 KYFGB/WSHfkZUBwOQxfgC8SOqHedYG/c+Zc81oKu6GoPyMqgbboKWxkd/gKgW+nvhX7l
 8wSONKoHD3rNpfyuSKyvrdOKs/mbZXIkVn0TvP7r3gODUrTR4VeCV3JcpSslfitCbZHQ
 03dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787722229; x=1788327029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VvmlYc4uR60GhmkrwN/xcN5jfUNAxmKzvS90Ij+le74=;
 b=YLQaCok1MDCawKbAU2TILgLyghpYkUYalZxl0/NAQC0O3A3Lz397N70c+WEdAgafBJ
 VzyHCmiR7ZhbZZhnFS0LldMoS2ylwLALHV2TLuZsmhLJw6FHtGrI0BCGZg8rWJ2FkYng
 dYkeY74oAIMYnbghr2GYz1+hqPfjeAyQIagMM77PxuX86+vAEklUiFk3ACMgQfohxxTz
 ZvVCVytqSxZztALjs02+E8oWiTunPhx+fvjL/fyVkG+DA0jS8pNYR77TY2reV/yZ+xLG
 tEBmt+6z6+HELuI/fTTrrw2hodksmfUMCSdoQrnNOGdrxBSbBOuOHYL/mm3Aj+c2gV52
 X85w==
X-Gm-Message-State: AFuF++nwKrv78bqeQZfEbIQDBnaGxP0uwtEVrUu5kx72GrpkR1Ll2GZw
 0m1Cg1Fu9/DxLoXjAlpys2niMfTtmoSh72e/BPHffhUtsSIGBRrJ54vk
X-Gm-Gg: AR+sD12jjqFVrrhoADngTWhxqmojTPLtO15jGh+WZySHvoCu8uhs5byCBJ2rWLCqz5Y
 rgBEbtDGBz5G3xCk746SaiygjdWVquWuNsKJFD4M6VZP5qCVApTvI89lF62rjqL2Llp3eZ/fHUH
 UShlPJb6YfzBuRJyJ6NrvUGp1mTAhaq6eEEo+TdjB3RiN8OpH3C0uEuliCwelBAYtqmQyPYSS3F
 uNuS/99qQ8HJzXq5JYibF5hY7Ya881WyKK0y5CShFWCXBKDojTWPzwk6SStORC0NiGkh//0Qf9O
 p1asZdi553ug5ijmMUHabZgxrUtAONEMnPEa33Yxk3Lbj/VLW3w47zjaVYBK06d+rQWawXXLUoU
 oFqFmwJ63hDX0Uzcx+fv8ptqLn5JtlzjKQal9XFta8ld6G6hTZLvP/DZ4DkC6OsElQBluEGOhSb
 Ksknn+iWCNBKMlKf9KN6r15g4P76ybbh31LzFj6WYzo1Sbge9EF5wIJy6+SLekkN9MoQ3Dbi4Ru
 /ltrf7cPIIh+sSd8Fh+VO4qi1nzAyPc351sKGlr5Uu5042+qMihlaqP+b+blebj43j29Z48Ytmh
 Nm3g9V7wragskWlRrBL5ue6ho5do+0geOyKgIyuvRBenUjnq43peR/hhGmBwuPIMuv4rS3HaOA3
 lWkzkN/7NsRD2FA==
X-Received: by 2002:a05:6870:658c:b0:434:5c90:9d87 with SMTP id
 586e51a60fabf-46599a0dfdfmr5045614fac.12.1787722228975; 
 Tue, 25 Aug 2026 22:30:28 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b0243574sm1346401fac.15.2026.08.25.22.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:30:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 23:29:46 -0600
Subject: [PATCH 07/10] net: lwip: allow DHCP to stop without releasing its
 lease
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-runtime-netconsole-v1-v1-7-0892966aa758@gmail.com>
References: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
In-Reply-To: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
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

U-Boot keeps using the address acquired by the dhcp command. The
existing lwIP stop operation sends DHCPRELEASE and clears the interface
address, which is unsuitable when the interface remains active for
another client.

Factor the common shutdown path and add dhcp_stop_without_release().
It stops the state machine and drops its UDP PCB reference without
sending DHCPRELEASE or clearing the interface address.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/core/ipv4/dhcp.c    | 39 ++++++++++++++++++++++++++---------
 lib/lwip/lwip/src/include/lwip/dhcp.h |  1 +
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/lib/lwip/lwip/src/core/ipv4/dhcp.c b/lib/lwip/lwip/src/core/ipv4/dhcp.c
index d9ed8b0f37a..bfc6cfe488e 100644
--- a/lib/lwip/lwip/src/core/ipv4/dhcp.c
+++ b/lib/lwip/lwip/src/core/ipv4/dhcp.c
@@ -1315,20 +1315,15 @@ dhcp_reboot(struct netif *netif)
   return result;
 }
 
-/**
- * @ingroup dhcp4
- * Release a DHCP lease and stop DHCP statemachine (and AUTOIP if LWIP_DHCP_AUTOIP_COOP).
- *
- * @param netif network interface
- */
-void
-dhcp_release_and_stop(struct netif *netif)
+/** Stop the DHCP state machine, optionally releasing its lease. */
+static void
+dhcp_stop_internal(struct netif *netif, int release)
 {
   struct dhcp *dhcp = netif_dhcp_data(netif);
   ip_addr_t server_ip_addr;
 
   LWIP_ASSERT_CORE_LOCKED();
-  LWIP_DEBUGF(DHCP_DEBUG | LWIP_DBG_TRACE, ("dhcp_release_and_stop()\n"));
+  LWIP_DEBUGF(DHCP_DEBUG | LWIP_DBG_TRACE, ("dhcp_stop_internal()\n"));
   if (dhcp == NULL) {
     return;
   }
@@ -1352,7 +1347,7 @@ dhcp_release_and_stop(struct netif *netif)
   dhcp->t1_renew_time = dhcp->t2_rebind_time = dhcp->lease_used = dhcp->t0_timeout = 0;
 
   /* send release message when current IP was assigned via DHCP */
-  if (dhcp_supplied_address(netif)) {
+  if (release && dhcp_supplied_address(netif)) {
     /* create and initialize the DHCP message header */
     struct pbuf *p_out;
     u16_t options_out_len;
@@ -1391,6 +1386,30 @@ dhcp_release_and_stop(struct netif *netif)
   }
 }
 
+/**
+ * @ingroup dhcp4
+ * Stop DHCP without sending DHCPRELEASE or removing the configured address.
+ *
+ * @param netif network interface
+ */
+void
+dhcp_stop_without_release(struct netif *netif)
+{
+  dhcp_stop_internal(netif, 0);
+}
+
+/**
+ * @ingroup dhcp4
+ * Release a DHCP lease and stop DHCP statemachine (and AUTOIP if LWIP_DHCP_AUTOIP_COOP).
+ *
+ * @param netif network interface
+ */
+void
+dhcp_release_and_stop(struct netif *netif)
+{
+  dhcp_stop_internal(netif, 1);
+}
+
 /**
  * @ingroup dhcp4
  * This function calls dhcp_release_and_stop() internally.
diff --git a/lib/lwip/lwip/src/include/lwip/dhcp.h b/lib/lwip/lwip/src/include/lwip/dhcp.h
index b413fa63f96..e7a79174f54 100644
--- a/lib/lwip/lwip/src/include/lwip/dhcp.h
+++ b/lib/lwip/lwip/src/include/lwip/dhcp.h
@@ -127,6 +127,7 @@ err_t dhcp_start(struct netif *netif);
 err_t dhcp_renew(struct netif *netif);
 err_t dhcp_release(struct netif *netif);
 void dhcp_stop(struct netif *netif);
+void dhcp_stop_without_release(struct netif *netif);
 void dhcp_release_and_stop(struct netif *netif);
 void dhcp_inform(struct netif *netif);
 void dhcp_network_changed_link_up(struct netif *netif);

-- 
2.53.0

