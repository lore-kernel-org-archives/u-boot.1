Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F77C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 17:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F7E840639;
	Sun, 27 Sep 2026 17:52:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eC5NaIbpFufZ; Sun, 27 Sep 2026 17:52:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 69B8440765
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790531531;
	b=FFvNhIC+X6ios+IrstpgQhN5+h3vrzksi4+JzNqIRwbdSB2oKa/N2ZE0jmKXpzfHthXK
	 FLYj74hOHHE91pySdo6g+NmRUODvFNYwlYN1BWsGp/XsjceERISpHE5vMgr2cgYkgYN+d
	 cOPJgaDmfilOd8B2DgZqwpV/gVNc9/JV+FaDDSYTvPOt4u0+AgMfsXeJnUNKm8kV2i9HV
	 +wcEX8MpPCX1BFPa1Ef+qg6KJ8Wo6p4SqiSF774231ehjtP7k19XWbhG0F46/Ls1c5sVv
	 xvrzsGGYNynfgJaYme+DhcgNAOLLXhU687wPDOUmoJZ33YKyffXJN0HCPmhBND1WRHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790531531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Info-Out:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-JNJ:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P1JfOWJYQ2AzZVeMxcBT0An3QgkOqhTci7LA6EqqAGc=;
	b=Z5AIn9Rh6PII2MTFKObLMUl/PdoCfbhrv/i3ugny+//G6EGam/7WXhYbvtYXI4SggF3B
	 pRvcd8XmAlHE2rrFhEgDdD09NK6VhL0nqD0pi0/pLSUdlSXN14gwNgdZZ+HcRI7Uu6+Gh
	 SnqELbFfJhMVv63BcgfoBuF9k7uG+aa4KuGh1b3C5xwTpmlGa0sHcwTjPakXR0pXwMW0j
	 u1hctd81/8fPaXtufkPiSi+evUE+1Z7tPGXR66AwiOjoLAsrzxlGqt30GQzX/ijKLwRZe
	 L7Fh9DnR9ZzKOstaCCVg47cS+8ZVbR3XQmNDiQgXYuKUoMU8rKjWnOT4Dwj05bB013g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=dxdmail.cc;
	dkim=pass header.d=dxdmail.cc header.i=@dxdmail.cc header.a=rsa-sha256 header.s=sig1 header.b=WnE1Q7xP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790531531;
	bh=P1JfOWJYQ2AzZVeMxcBT0An3QgkOqhTci7LA6EqqAGc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Oo8uvTAqQl1zbE3cove09LI3e9f/M5ZY9HF77yx0sYOq71dCL3umsCfyM6M22clxo
	 E+aklEYFRDJpuypjdLoFKbhzlOkC8KOMwhYA5sdGUR7r4ymkQGrU1KaZIWc5BfQ1Iw
	 bZo9TKd5d9ksXBuGEWGu+S47LPgXYWtjL09FPq3woMeVaPSIkNLTg/gXg24zJ0qYJM
	 jDUL/S/1k+HEKouC0g+yfxFkloP0Sh6DLgd7OTKnNJU5eectI3oHJR9g2axxyrYMli
	 XMJSgT4ALt2cE13UyCtSn7FxUtUinbLdEGRF1Hpd+Q8KdIuhFMbnAXR1teeYyfE5Qk
	 XUgUall1rDdHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69B8440765;
	Sun, 27 Sep 2026 17:52:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E746622B
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 17:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBFC140763
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 17:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AnIvzCN3tILD for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 17:05:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1496D4068B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:b747:3002:205::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790528757;
 b=Bh4fzhMKgJzOgPBZo8dzv6wHSwK+sTCtzqHii6qhWoEBA5PnNmRxqSO8zAVZQZccRzu7
 PLtxu7xdS/90gU8kWc5+2vHnMldtoFQiSUFAlqDaGAC/cci4eFRgJ3puRc+1Uim5EqHs3
 KKP+ZXIN9uUGOtSO5oyEnt5109lLYopx2PCEHqeFtijWdG9FUPGAD88UyL677IPnY69Jp
 /n7N4dSCxFkkPfxgFjETPW/DgNlQjKebGkkBGAAcvCtzHMNH1hSYOZ20vsY7kUpY1eXSF
 fAvWHVWOGQ+nz3cfA2TgIDGsO6RBRTalsqclc9fyP1H3LmJ6TKSEo+otksqvLKmNWog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790528757;
 h=X-Greylist:Received-SPF:Received:X-ICL-RepId:X-ICL-Out-Info:
 Dkim-Signature:mail-alias-created-date:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-GUID:X-Authority-Info-Out:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-JNJ;
 bh=P1JfOWJYQ2AzZVeMxcBT0An3QgkOqhTci7LA6EqqAGc=;
 b=s/WuUC7Wh9FSZFnv44wpUGlyQpxp7qxli08eAabpz/NYwdQNv9CFTv+djqkuc5M2PlY2
 X+7xpKE6C48ngvRMCJAcptfDoijZXj6/h18xUFb+wgAUICqU0LL3QxeHiy+KxqxZxACH+
 etJwwxNsLHH6+Oe75mbFpNryiXRTSBS/WHd0PkgTCfbYeEH4BPMBVa/mVzYqRgAn0Tfcl
 7OSMuOX6a9Uv4dmo+j7RpptLoxEGr2J3IEErDtxR3YO0Ti3TgUhS420e0WgVEIqg38YVf
 GAypS/OezT5pg6Fjy/pz+3PNG+EhbD+PgmmBnP1SrMqc1uCOiU7AFuDBmynUcC2BDYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=dxdmail.cc; 
 dkim=pass header.d=dxdmail.cc header.i=@dxdmail.cc header.a=rsa-sha256
 header.s=sig1 header.b=WnE1Q7xP; 
 arc=none smtp.remote-ip="2a01:b747:3002:205::b"
X-Greylist: delayed 1801 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 27 Sep 2026 17:05:57 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=dxdmail.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dxdmail.cc header.i=@dxdmail.cc header.a=rsa-sha256
 header.s=sig1 header.b=WnE1Q7xP
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3002:205::b; helo=outbound.ms.icloud.com;
 envelope-from=nacht@dxdmail.cc; receiver=<UNKNOWN> 
Received: from outbound.ms.icloud.com (ms-2004a-snip6-11.eps.apple.com
 [IPv6:2a01:b747:3002:205::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1496D4068B
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 17:05:56 +0000 (UTC)
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-5 (Postfix) with ESMTPS id
 395281800303; Sun, 27 Sep 2026 16:28:38 +0000 (UTC)
X-ICL-RepId: 01a0e3b2-7391-7630-9e4e-8ff66887298c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFBHV8DXhxCDFYCXARLVxQEFlIOXx9yFEEcXgxeBxwTWlhVCQoPShRUGVoBGQhRUEsbDloXA1ccVkVcGEMJXQVXHB0AREVbE1UXRgkZCF0dGQhHHwowA0IOVgNDB0UALRkcV1BTE1YdWBFfQ1QIEh1QHA5RBVsARglBAVoGXQBHDUgdXgJSAUIKTx5cGgVTE1EMcwlPD18RUBQdDlRVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxdmail.cc; s=sig1;
 t=1790526520; x=1793118520; bh=P1JfOWJYQ2AzZVeMxcBT0An3QgkOqhTci7LA6EqqAGc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WnE1Q7xPMaFed1jl4haELR4GwvPUG6xLsbsuPj/Wb5ysy1HFfqCUlkMNGXj5hAmTXwQOyuJV7LmGr5Rhdndw9ZHhYxW/3IFRt+ROerSeOS3OvDY0vxoR/XOpAcal7AMdyF5Qb73+efSnUBbRDheF7Se4rii0Y3z0VeUiJMMivPfLnD8jSGB8GCCwKppa/QhjRHQvu1cmywhK7WD8RQzCPZOG/MqMf87GwiHx0xYTwYIe7sfflTiKzCv57TZzxkDnfnI/17ySQsSccTwYk9e/jP4X1WV3G9ldOmM70pnAbnFDKP2uoWw7Jv2+Ahz3zY3lB2KIUmanYN0h+XUgcRImow==
mail-alias-created-date: 1790174225171
Received: from fedora.fritz.box (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-5 (Postfix) with ESMTPSA id
 44BF918000E5; Sun, 27 Sep 2026 16:28:36 +0000 (UTC)
From: nacht20-de <nacht@dxdmail.cc>
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Loic Poulain <loic.poulain@linaro.org>, Tom Rini <trini@konsulko.com>,
 nacht20-de <nacht@dxdmail.cc>
Subject: [PATCH] usb: gadget: acm: do not requeue failed RX requests
Date: Sun, 27 Sep 2026 18:27:40 +0200
Message-ID: <20260927162740.3593237-1-nacht@dxdmail.cc>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QpqU2U_0f0r6a1vAdmM421Kj73QCWQqy
X-Authority-Info-Out: v=2.4 cv=P/43RyAu c=1 sm=1 tr=0 ts=6ab94437
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=TcA7qK3IVxbl8t8k5AMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2NSBTYWx0ZWRfX9TFxf/KNxQee
 3kpMe1LGtwpCYffLiTbWc+UJKFHmTZ24VhqK9cWRKmhNT7cZO+l6WG1Ca2aMS/Bo9DNcbI1B0vO
 snnVF7IMxwY8f8HJia80/pGkdhYXji8bq8esA0kgWNegMIYqmzjn3C8RiV2VvLrCoTANfoZRrVs
 tjKNEnf8qxvZSg/d3KPnpDjveVrRMoNr95Abkjpyn8Jfu6ptsTJYId4hqKn+UT6K6bL87bzDeJ5
 bpyx9ag4ofB+U0jQ1/3o6zSeYBLn0gsTon0MkxaVyypC3skoMKhKNQwDByanlkLtT9VnyLmaLI+
 QWjNV0ss7/vv7xK5l5Y1oeGNWQ/1uOWUGbVrz2FrOANLG3PvZO26nuzLnXhyUg=
X-Proofpoint-ORIG-GUID: QpqU2U_0f0r6a1vAdmM421Kj73QCWQqy
X-JNJ: AAAAAAAB2PlFUP0XxWW0elo4nAlMTu/bVXExWYSZB2fsRX0WcrvgscoUIqCe93CReFEtuB3ADuJPn9VjZonNW+8b2NTlxLrTZDvbYoVM5L8O1di0iXeImF5XmB1vDUttSNjDSSLvv2Gyh4Mi2QP7RZ3qW/E37SIAN9qfVyc/oSMoXEPXKScZzI9GVFNuhoMFSCB8JyTMLpdSXFsmR/dws0kQrUOSs7wLZTFlH+zkuXWV16ARpw9DvrNd3OqAaWJb4emZ4pTlzIXf0EyRkzAHH79FejAwHX2Z+1EN9piqj0cCZplG4dCon68ADFsEy+sE/Iw6fMggC/SAde9raHULZBNnycMUfQUdyqP2/+CXMhQYJolrqFjYZKoIN6/gSocns6GymI54hyjm/eNLZpS5TWc5Ewmf2dYd3/5SXGsm+Y5xlhLTr+yj5eASEMUzZV4Y9bteadP30KptR15xxUlXRzysoX755y+fmrdgeCwz3b/TELhNn7uAn/TUB9JNdDCxvZ+HLcnM6yVzkSRMbb44HFFMkUbhH7QicEBaSnJ16UxhNidTNZulCXHg62ge6B05Aza60XjPEHyIasAmvLM3TUC/WdKTwnXcc1tBdEzc0g3lH/1tcbxCREv4/Gs4Wz9A1GyCFiIOvp8gAlBs4Jkd5gX8ALPSoKyo7l/VwTBdy0Z1s+mfFHxbAYTMRhL0n4EuKXmlEuBbAxncqIc14AOTXWdDQ9LLWCyPOAsfzsJGHR5PlJxwk4MjuYmRrhuM3J7S/N36LO39cJbQxT4QuP+ENxy6ln/R1QtiDXohUxQ2D1l/NKnwDS7ru6iiFcLUFN79sSwt5A7zsglksPCr4NdC2rMn3RcMc3t55F/UC18BXgqbfaoDNTk3cmXD7bN6rUc8TqcjFzzY9mDZxz+WD7oqLAP1VWfaUfNidEDwcqJbSkOy8zVf1DPpllIY50B8wodV5rBICEnDNSBkcjSUrKkNGiCYOKjy3Qh
 pcCrbwvQ6wtkhgJdv6g/gtJ7rKOOeHM6K2RZcgD0A8BuoLwiFMl/0cWObr6UY9FgobxZSksPzJVHWC0eH1zLZWa8NalDz4jJpLdlm4PYUje7Nah9nrKgEnMMlYL8v5ndDcjQOIwZya3Om7qTvoXdtIUsCfX9fuM+N/VwTYNYZW0OsS/dnocd+SR8bgBxHAApSzbo5sp8SmdqEl9KtlTv3wvnUn0+RlL4fxh0hhWA1EyzLWgKDTyLtXO7nPA5WD2TQHjIJZPYDQZosmyCxdOrmW6V9TXm9TB4AuJ5tROiM
X-Mailman-Approved-At: Sun, 27 Sep 2026 17:52:10 +0000
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

acm_rx_complete() pushes the received data into the RX buffer and
queues the request again, regardless of its completion status.

When an endpoint is disabled, the UDC gives back its queued requests
with an error status such as -ESHUTDOWN.  This happens when the ACM
function is disabled on a bus reset or disconnect, or when the usbacm
console is stopped.  Requeueing such a request from its completion
handler puts it back on the endpoint that is being flushed.  With DWC3,
dwc3_remove_requests() then gives the same request back again and
again, usb_ep_disable() never returns, and gadget teardown stalls.

Return early for failed completions, as the fastboot and rockusb
functions already do.  A failed request carries no valid data.  It is
freed by acm_disable(), and acm_set_alt() queues a new one when the
data interface is enabled again.  Successful completions are handled
as before.

Fixes: fc2b399ac03b ("usb: gadget: Add CDC ACM function")
Signed-off-by: nacht20-de <nacht@dxdmail.cc>
---
 drivers/usb/gadget/f_acm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index b6c11d97a62..2ea54dfbe69 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -293,6 +293,9 @@ static void acm_rx_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_acm *f_acm = req->context;
 
+	if (req->status)
+		return;
+
 	buf_push(&f_acm->rx_buf, req->buf, req->actual);
 
 	/* Queue RX req again */
-- 
2.55.0

