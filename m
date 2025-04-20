Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCB1C369D2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 00:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF37B8213D;
	Sun, 20 Apr 2025 02:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745110112;
	bh=pEFWra6fpmWFuJnNYUeNeO3uDxQhzr5SQJWZMWqLqOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tsZE9qywWDXEbgrtLTsI6su+5Bpt1tXGPSaguFGOSqah5rJQoZjjW9jD9Nkbg1ckS
	 z2ppaf0/4m0NSnbYnGX8VBK1dF1+4uOpH+xaPls7MA5oM8nO1+Rw6IRFRrzU4oBQ03
	 CjZRQf4duPTKHsReo696g92kClxH3QqaeobwdAJOgGT4QYm/yFsetFAoiF6lhCB035
	 LotsVRcc2sudRtQOqHawZSKfPKaVvFBdEe+6qsCpQXwgSqHtVu+nkLdCVf1j9a56nt
	 MivwM6e+jLUX2L9p/Oog7GLWo6VJAXfmuNpzOSKScPG6SsyyMLuEa5JNnw5CVdxi7x
	 EDgys09DM7lmg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED27820EB; Sun, 20 Apr 2025 02:48:29 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788E5820EB
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 02:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="B6V8zZZZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 33E67103B92C0; 
 Sun, 20 Apr 2025 02:48:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745110106; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-language:in-reply-to:references;
 bh=pEFWra6fpmWFuJnNYUeNeO3uDxQhzr5SQJWZMWqLqOE=;
 b=B6V8zZZZZ4fq5PEqV+uza/8jFxt1LbIsHDe0c3j1YLt45eGcbroYTMVMELyCfzcOcaVJAA
 pnay2PbqwZNxy/Sn0hasWwJYs+FXKFbWCEPmjr9ljYscXhBYoupY/k3pJBOFj2SQXTITLe
 wXSUxOjy+RVCPs2xwoXQIzH9yTh+f83Oo7Q0GkkqlOD947cF3zR+qRgF1NzsudvMrHuiOI
 v9nmPbnTulNysZyW7WEjLkqu2oMlka6aCPk8gM0gbWKOJUBHNNEcGi9IRvEXAZH40zB3XZ
 F+/J32PErILNhOCeLMVFLQvCfzySYMVoROV1kbs/+leF/4KxaC/KqeMgNx3PyQ==
Content-Type: multipart/mixed; boundary="------------x03itpwH0QrqGcqVcGF3rvwY"
Message-ID: <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
Date: Sun, 20 Apr 2025 02:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This is a multi-part message in MIME format.
--------------x03itpwH0QrqGcqVcGF3rvwY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/19/25 10:40 PM, Adam Ford wrote:
> On Sat, Apr 19, 2025 at 2:12 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Hi Marek,
>>
>> On Fri, Apr 18, 2025 at 11:53 AM Marek Vasut <marex@denx.de> wrote:
>>
>>> The "clock-output-names" is NEVER used for any clock look up.
>>
>> In Linux, "clock-output-names" is used to register the name of the
>> fixed-rate clock.
>>
>>  From Linux drivers/clk/clk-fixed-rate.c:
>>
>> ```
>> static struct clk_hw *_of_fixed_clk_setup(struct device_node *node)
>> {
>> ....
>>
>> of_property_read_string(node, "clock-output-names", &clk_name);
>>
>> hw = clk_hw_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
>>      0, rate, accuracy);
>> ```
>>
>> In U-Boot, we should register a fixed-rate clock with the same name as in Linux.
>>
>> This patch aims to make the U-Boot fixed-rate clock name conform to
>> Linux standards.
>>
>>> I am fine with the first half of the description, but the second half is
>>> wrong and this actually does not fix anything. Simply remove
>>> clock-output-names from the osc_24m and the code will be broken again.
>>
>> In Linux, if "clock-output-names" is removed from the osc_24m node,
>> the console becomes corrupted
>> on an imx8mp-evk.
>>
>>> The clk_resolve_parent_clk() is meant to perform the aforementioned
>>> resolution(), that is what "[PATCH v2 00/24] clk: Add
>>> clk_resolve_parent_clk() and fix up iMX clock drivers" actually fixed.
>>> It seems there is something still missing and clk_resolve_parent_clk()
>>> does not do the resolution properly for some clock, but that is what
>>> needs to be understood and fixed, not worked around this way.
>>
>> Please try to reproduce the problem on your end.
>>
>> On an imx8mp-based board, run 'usb start' in U-Boot, and this command will fail.
> 
>  From what I can tell, on the imx8mp, the usb_phy_ref parent->dev->name
> value s "clock-osc-24m" which never matches "osc_24" and I put some
> debug code into clk_mux_fetch_parent_index.
> 
> I think clk_mux_fetch_parent_index needs some additional logic to go
> up the chain to the root node and look for 'clock-names' to match in
> addition to what it already does. I am just not sure of the best
> method to go up the tree to find the root node that defines it.
[...]

Try something like this (also attached), maybe this needs to be made 
generic ?

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 9e3b5191767..207224b1320 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -155,6 +155,8 @@ struct clk *clk_register_composite(struct udevice 
*dev, const char *name,
  		goto err;
  	}

+	composite->dev = dev;
+
  	if (composite->mux)
  		composite->mux->dev = clk->dev;
  	if (composite->rate)
diff --git a/drivers/clk/imx/clk-composite-8m.c 
b/drivers/clk/imx/clk-composite-8m.c
index 14c5b92939c..e1a3c0af308 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -116,14 +116,42 @@ static const struct clk_ops 
imx8m_clk_composite_divider_ops = {
  	.set_rate = imx8m_clk_composite_divider_set_rate,
  };

+static int imx8m_clk_mux_fetch_parent_index(struct udevice *cdev, 
struct clk *clk, struct clk *parent)
+{
+	struct clk_mux *mux = to_clk_mux(clk);
+	struct clk cclk;
+	int ret;
+	int i;
+
+	if (!parent)
+		return -EINVAL;
+
+	for (i = 0; i < mux->num_parents; i++) {
+		ret = clk_get_by_name(cdev, mux->parent_names[i], &cclk);
+		if (!ret && ofnode_equal(dev_ofnode(parent->dev), dev_ofnode(cclk.dev)))
+			return i;
+
+		if (!strcmp(parent->dev->name, mux->parent_names[i]))
+			return i;
+		if (!strcmp(parent->dev->name,
+			    clk_resolve_parent_clk(clk->dev,
+						   mux->parent_names[i])))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+
  static int imx8m_clk_mux_set_parent(struct clk *clk, struct clk *parent)
  {
  	struct clk_mux *mux = to_clk_mux(clk);
+	struct clk_composite *composite = (struct clk_composite *)clk->data;
  	int index;
  	u32 val;
  	u32 reg;

-	index = clk_mux_fetch_parent_index(clk, parent);
+	index = imx8m_clk_mux_fetch_parent_index(composite->dev, clk, parent);
  	if (index < 0) {
  		log_err("Could not fetch index\n");
  		return index;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5ea2171492e..267757939e0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -219,6 +219,8 @@ struct clk_composite {
  	const struct clk_ops	*mux_ops;
  	const struct clk_ops	*rate_ops;
  	const struct clk_ops	*gate_ops;
+
+	struct udevice *dev;
  };

  #define to_clk_composite(_clk) container_of(_clk, struct 
clk_composite, clk)

--------------x03itpwH0QrqGcqVcGF3rvwY
Content-Type: text/x-patch; charset=UTF-8; name="clk.diff"
Content-Disposition: attachment; filename="clk.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYyBiL2RyaXZlcnMvY2xr
L2Nsay1jb21wb3NpdGUuYwppbmRleCA5ZTNiNTE5MTc2Ny4uMjA3MjI0YjEzMjAgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYworKysgYi9kcml2ZXJzL2Nsay9j
bGstY29tcG9zaXRlLmMKQEAgLTE1NSw2ICsxNTUsOCBAQCBzdHJ1Y3QgY2xrICpjbGtfcmVn
aXN0ZXJfY29tcG9zaXRlKHN0cnVjdCB1ZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUs
CiAJCWdvdG8gZXJyOwogCX0KIAorCWNvbXBvc2l0ZS0+ZGV2ID0gZGV2OworCiAJaWYgKGNv
bXBvc2l0ZS0+bXV4KQogCQljb21wb3NpdGUtPm11eC0+ZGV2ID0gY2xrLT5kZXY7CiAJaWYg
KGNvbXBvc2l0ZS0+cmF0ZSkKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstY29t
cG9zaXRlLThtLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0ZS04bS5jCmluZGV4
IDE0YzViOTI5MzljLi5lMWEzYzBhZjMwOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jbGsvaW14
L2Nsay1jb21wb3NpdGUtOG0uYworKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0
ZS04bS5jCkBAIC0xMTYsMTQgKzExNiw0MiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19v
cHMgaW14OG1fY2xrX2NvbXBvc2l0ZV9kaXZpZGVyX29wcyA9IHsKIAkuc2V0X3JhdGUgPSBp
bXg4bV9jbGtfY29tcG9zaXRlX2RpdmlkZXJfc2V0X3JhdGUsCiB9OwogCitzdGF0aWMgaW50
IGlteDhtX2Nsa19tdXhfZmV0Y2hfcGFyZW50X2luZGV4KHN0cnVjdCB1ZGV2aWNlICpjZGV2
LCBzdHJ1Y3QgY2xrICpjbGssIHN0cnVjdCBjbGsgKnBhcmVudCkKK3sKKwlzdHJ1Y3QgY2xr
X211eCAqbXV4ID0gdG9fY2xrX211eChjbGspOworCXN0cnVjdCBjbGsgY2NsazsKKwlpbnQg
cmV0OworCWludCBpOworCisJaWYgKCFwYXJlbnQpCisJCXJldHVybiAtRUlOVkFMOworCisJ
Zm9yIChpID0gMDsgaSA8IG11eC0+bnVtX3BhcmVudHM7IGkrKykgeworCQlyZXQgPSBjbGtf
Z2V0X2J5X25hbWUoY2RldiwgbXV4LT5wYXJlbnRfbmFtZXNbaV0sICZjY2xrKTsKKwkJaWYg
KCFyZXQgJiYgb2Zub2RlX2VxdWFsKGRldl9vZm5vZGUocGFyZW50LT5kZXYpLCBkZXZfb2Zu
b2RlKGNjbGsuZGV2KSkpCisJCQlyZXR1cm4gaTsKKworCQlpZiAoIXN0cmNtcChwYXJlbnQt
PmRldi0+bmFtZSwgbXV4LT5wYXJlbnRfbmFtZXNbaV0pKQorCQkJcmV0dXJuIGk7CisJCWlm
ICghc3RyY21wKHBhcmVudC0+ZGV2LT5uYW1lLAorCQkJICAgIGNsa19yZXNvbHZlX3BhcmVu
dF9jbGsoY2xrLT5kZXYsCisJCQkJCQkgICBtdXgtPnBhcmVudF9uYW1lc1tpXSkpKQorCQkJ
cmV0dXJuIGk7CisJfQorCisJcmV0dXJuIC1FSU5WQUw7Cit9CisKKwogc3RhdGljIGludCBp
bXg4bV9jbGtfbXV4X3NldF9wYXJlbnQoc3RydWN0IGNsayAqY2xrLCBzdHJ1Y3QgY2xrICpw
YXJlbnQpCiB7CiAJc3RydWN0IGNsa19tdXggKm11eCA9IHRvX2Nsa19tdXgoY2xrKTsKKwlz
dHJ1Y3QgY2xrX2NvbXBvc2l0ZSAqY29tcG9zaXRlID0gKHN0cnVjdCBjbGtfY29tcG9zaXRl
ICopY2xrLT5kYXRhOwogCWludCBpbmRleDsKIAl1MzIgdmFsOwogCXUzMiByZWc7CiAKLQlp
bmRleCA9IGNsa19tdXhfZmV0Y2hfcGFyZW50X2luZGV4KGNsaywgcGFyZW50KTsKKwlpbmRl
eCA9IGlteDhtX2Nsa19tdXhfZmV0Y2hfcGFyZW50X2luZGV4KGNvbXBvc2l0ZS0+ZGV2LCBj
bGssIHBhcmVudCk7CiAJaWYgKGluZGV4IDwgMCkgewogCQlsb2dfZXJyKCJDb3VsZCBub3Qg
ZmV0Y2ggaW5kZXhcbiIpOwogCQlyZXR1cm4gaW5kZXg7CmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2Nsay1wcm92aWRlci5oIGIvaW5jbHVkZS9saW51eC9jbGstcHJvdmlkZXIuaApp
bmRleCA1ZWEyMTcxNDkyZS4uMjY3NzU3OTM5ZTAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvY2xrLXByb3ZpZGVyLmgKKysrIGIvaW5jbHVkZS9saW51eC9jbGstcHJvdmlkZXIuaApA
QCAtMjE5LDYgKzIxOSw4IEBAIHN0cnVjdCBjbGtfY29tcG9zaXRlIHsKIAljb25zdCBzdHJ1
Y3QgY2xrX29wcwkqbXV4X29wczsKIAljb25zdCBzdHJ1Y3QgY2xrX29wcwkqcmF0ZV9vcHM7
CiAJY29uc3Qgc3RydWN0IGNsa19vcHMJKmdhdGVfb3BzOworCisJc3RydWN0IHVkZXZpY2Ug
KmRldjsKIH07CiAKICNkZWZpbmUgdG9fY2xrX2NvbXBvc2l0ZShfY2xrKSBjb250YWluZXJf
b2YoX2Nsaywgc3RydWN0IGNsa19jb21wb3NpdGUsIGNsaykK

--------------x03itpwH0QrqGcqVcGF3rvwY--
