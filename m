Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DB9C624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 17:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAB3B80E7B;
	Tue,  1 Sep 2026 17:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcXKCVD3K5wN; Tue,  1 Sep 2026 17:09:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788282594;
	bh=VvmlYc4uR60GhmkrwN/xcN5jfUNAxmKzvS90Ij+le74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l2Z8DBcWTRCsilbcWiMBK53BA/k8Y8PYtO4KBM+THGc7/hqOUwg2RS4KdfUgNzgEf
	 Rtsy8eXVfxsujjeEJvDhdvdr1+tWM9gdBiyxONgNgaaQ5gbC8cjNnjfNFKYhq1saw1
	 1z6yQH+VtJp6CcS2jc9n3tB63Azwaht9hYL4Gt1v9IWw5UG58O8AS+52ARXi/UaKHZ
	 fyIlFWC8V7leUDekePCOhzILrdXZN6fEw/HSIk53vhV5v7tEP1jR6Pw9XesMU8LPsz
	 elwFCVKhntKcFplgjtvTRr0e4+TcWjKOd7DquCprw99/7rMPH75MEf+dQvQc7dxOz6
	 mquNVq3Hge4Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD0F680E68;
	Tue,  1 Sep 2026 17:09:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CB992FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F38E606F6
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hi3xp-dlyI7o for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:09:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=T7xzSHi/
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88D3060633
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:48 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f4e6b5bd30so986571a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788282587; x=1788887387;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VvmlYc4uR60GhmkrwN/xcN5jfUNAxmKzvS90Ij+le74=;
 b=T7xzSHi/RlozCPQgcvvyh9YlwQmfEVaymIOsDyUg+piAjnYfIxVcR88g3av74J0Uzt
 g4D38I3hjwSOejKcrbjLRk1x6xZFc7wuUo6Q5Cg59fOmdm7jL85GRj8GdZhoVQaerb6R
 XDt0GP1DVah4is+WHdHUsAJhAdrzcasL0Wv0sis/ep/lcu0gytc5uGqgIKt7it3RVUXS
 rjnKIU0bk3JQy9083XqUU/pTycdlvoh3ehUw5K9VWORu30uZeHKWz0xO9a6hy+PougXQ
 4SdgqhhVvGcFkKFoB9k4Eo0sd4jCnl7CRX0Eiv/+SIq07YqoDwQJvmurLYLfzhkPNC8l
 bgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282587; x=1788887387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VvmlYc4uR60GhmkrwN/xcN5jfUNAxmKzvS90Ij+le74=;
 b=FN9YW0I71xiSQ/g+GMseVd3iFVuQC6F10Bj8l5oPmKfAXHLblO/QmsGUyfLaiu6Mnc
 FUfiLWy/8vt/JZOcAJAjxqwYgobfb/95R06IV4E6N0zPtLtN3nnxIa+IpserCaJw9at9
 7ltiDX/d/asfXYmtHoKP/yYw0QsjKnW1xHwnizbS55ltlS+sKl9tY2jQNOmw8H1LhPoP
 9HU0K4Zfav3hba9oTbZ2ck7X3ecRn6nwXTJ+mUbhngB05xhdqieFfnK7zrUNkXKJKNqz
 yDWhfHorN1aZE9oD0FsaNH7uVV+5pOvM0dk5YW5TTpulNBz8vcS5hTQLcZ/G7JTUSaFT
 FKxQ==
X-Gm-Message-State: AFuF++myPNfxyCpW9DNFbEGUpWF2ZZIfu5U6lGl/JlTYH6XNvSXtdj/B
 Q8wj3W5SMG3pQRBB5vBov4kvXvmpDNX4cjCfoUfEjqedUamt/2puw1ey
X-Gm-Gg: AR+sD13k4zF43uxIHIc9poxZ0j3hfr4GkD90sh+p8pxuPCKVsA7p4Ne7iMRyQCauJOf
 90lHucFi1s9EWfbtZ+IhzHtDksaLuKC4OVp+XcVvs7kU2CcA0EMtp1LRYYqLmBh/t+JuI1JEmSz
 b6mrMwhqo6IahIYzIUDthSgDhJXQOO6yNHZuopv6Zbhpfhe4nKoxBd6r9y/X0zvjmMivd3IanZa
 6nlwp+7hU+MAjOSYKq6v8Z2+vDT3TKIPCtRyaTqOBsxdto9B5xiRYMYwqqY2tivf6RSQdpsdIW+
 S8JJvq27scHfu0Nmltujx1cQutNX9cYq4OMVefwop3aL3cRlEv34FFq+pWccGjs4JIEVeZDC1Hx
 cJMpormvT+4RZhbvT0CHG5fBSsmXGEsocrgAmYrJYMP6ce8ou3rLlEkUsVchz4iiBEzoqHFK0Aa
 FaCQ1SpFwZiiPySLzDPUtnP2IqjDjKwMDIFpLcJA6X7ScY2bhZwRGN1eVyXkRm4eX3AiidNBDbU
 sv9GeOyPHhp1VrRUvJWFN6Ex2pX3L31A1tnHjmHKWo1dN8i0jOXimnmWmFYePH9LyDNgwDh6W0D
 klP0Nnly/jFpNPDeMRItR5BJ61I1PksKsMCosI2IHIhpzb5j5d5A3LA2NCjYWVlQ8+dHNlWiL8I
 8+MFlmlXzwc6ixjdlu8s=
X-Received: by 2002:a05:6830:33e6:b0:7e9:d34a:f436 with SMTP id
 46e09a7af769-7f68f893dfamr4315441a34.17.1788282586932; 
 Tue, 01 Sep 2026 10:09:46 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm10892218a34.19.2026.09.01.10.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 01 Sep 2026 11:09:01 -0600
Subject: [PATCH v2 07/10] net: lwip: allow DHCP to stop without releasing
 its lease
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-submit-lwip-runtime-netconsole-v1-v2-7-3e3d95627cf9@gmail.com>
References: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
In-Reply-To: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>
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

